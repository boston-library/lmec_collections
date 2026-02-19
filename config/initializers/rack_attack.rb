# frozen_string_literal: true

Rack::Attack.safelist('allow from localhost') do |req|
  # Requests are allowed if the return value is truthy
  ['127.0.0.1', '::1'].include?(req.ip)
end

Rack::Attack.throttle('requests by ip', limit: 10, period: 1.minute) do |req|
  req.ip if req.path.include?('/start_download/')
end

Rack::Attack.blocklist('block ips') do |req|
  Rails.cache.read("favorites-add-item-bot:#{req.ip}")
end

# GET requests to /favorites/:id/add-item are likely bots
# (this route doesn't exist, clicks from browser produce POST request)
Rack::Attack.blocklist('block ips going to GET /favorites/:id/add-item') do |req|
  if req.get? && req.path.match?(/favorites\/[0-9]*\/add-item/)
    Rails.cache.write("favorites-add-item-bot:#{req.ip}", true, expires_in: 30.days)
    File.write(Rails.root.join('log/favorites-add-item-bot_blocked-ips.log').to_s, "#{req.ip} - [#{DateTime.now.strftime('%Y-%m-%dT%H:%M:%S')}] - #{req.path} - #{req.user_agent.inspect}\n", mode: 'a')
    true
  else
    false
  end
end

Rack::Attack.throttled_responder = lambda do |env|
  match_data = env['rack.attack.match_data']
  now = match_data[:epoch_time]
  retry_after = match_data[:period] - (now % match_data[:period])

  headers = {
    'Content-Type' => 'text/plain',
    'Retry-After' => retry_after.to_s,
    'RateLimit-Limit' => match_data[:limit].to_s,
    'RateLimit-Remaining' => '0'
  }

  [429, headers, ["Retry later\n"]]
end

ActiveSupport::Notifications.subscribe('throttle.rack_attack') do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  Rails.logger.warn '--------------------------------------------------------------'
  Rails.logger.warn 'WARN: Client exceeded rate limit'
  Rails.logger.warn 'Request Info:'
  Rails.logger.warn "<Request Name: #{event.name}; ID: #{event.transaction_id}; Duration: #{event.duration} />"
  Rails.logger.warn "< #{event.payload.inspect} />"
  Rails.logger.warn '--------------------------------------------------------------'
end