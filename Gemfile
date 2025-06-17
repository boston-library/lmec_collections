source "https://rubygems.org"

gem "rails", "~> 7.2.2", ">= 7.2.2.1"
gem "propshaft"
gem "sqlite3", ">= 1.4"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "rsolr", ">= 1.0", "< 3"
gem "bootstrap", "~> 5.3"
gem "devise"
gem "devise-guests", "~> 0.8"
gem "openseadragon", "~> 1.0"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "bootsnap", require: false

gem 'commonwealth-vlr-engine', github: 'boston-library/commonwealth-vlr-engine', branch: 'blacklight-8'

group :development, :test do
  gem 'dotenv', '~> 3.1', '>= 3.1.8'
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "solr_wrapper", ">= 0.3"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
