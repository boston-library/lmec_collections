source "https://rubygems.org"

gem "rails", "~> 7.2.2", ">= 7.2.2.1"
gem "propshaft"
gem 'pg', '~> 1.5', '>= 1.5.9'
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "rsolr", ">= 1.0", "< 3"
gem "devise"
gem "devise-guests", "~> 0.8"
gem "openseadragon", "~> 1.0"
gem 'turbolinks', '~> 5.2', '>= 5.2.1'
gem 'uglifier', '~> 4.2', '>= 4.2.1'

gem 'jquery-rails', '~> 4.6'
gem 'coffee-rails', '~> 5.0'
gem 'deep_cloneable', '~> 3.2', '>= 3.2.1'

gem 'devise_cas_authenticatable', '~> 2.0', '>= 2.0.2'
gem 'omniauth-polaris', '~> 1.0'
gem 'activerecord-session_store', '~> 2.2'

gem 'kaminari', '~> 1.2', '>= 1.2.2'
gem 'logger', '~> 1.7'
gem 'mimemagic', '~> 0.4.3'
gem 'smt_rails', '~> 0.3.0'

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "bootsnap", require: false

gem 'commonwealth-vlr-engine', github: 'boston-library/commonwealth-vlr-engine', branch: 'blacklight-8'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 2.6', '>= 2.6.1', group: :doc

group :development, :test do
  gem 'spring'
  gem 'byebug'
  gem 'dotenv', '~> 3.1', '>= 3.1.8'
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "solr_wrapper", ">= 0.3"

  gem 'simplecov', '~> 0.22.0'
  gem 'rspec', '~> 3.13', '>= 3.13.1'
  gem 'rspec-rails', '~> 8.0'
  gem 'rubocop', '~> 1.76', '>= 1.76.2'
end

group :development do
  gem "web-console"
  gem 'guard-livereload', require: false
  gem 'listen', '~> 3.9'
  gem 'rack-livereload', '~> 0.6.1'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
