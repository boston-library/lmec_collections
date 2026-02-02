# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

require 'blacklight/allmaps/rake_task'

if %w[development test].member?(ENV.fetch('RAILS_ENV', 'development'))
  task default: :ci
  Rake::Task.define_task(:environment)

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.requires << 'rubocop-rails'
    task.requires << 'rubocop-rspec'
    task.fail_on_error = true
  end

  desc 'Run linting and specs'
  task ci: %i[spec rubocop]
end
