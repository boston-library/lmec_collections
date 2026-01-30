# frozen_string_literal: true

module ControllerHelpers
  def login_with(user = nil, scope = :user)
    current_user = :"current_#{scope}"
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, scope: scope)
      allow(controller).to receive(current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(current_user).and_return(user)
    end
  end
end
