# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

## Error comes during `deploy:assets:precompile` because of not loading `solr_wrapper/rake_task`
## require 'solr_wrapper/rake_task' unless Rails.env.production?
require 'blacklight/allmaps/rake_task'
