# frozen_string_literal: true

# Load DSL and set up stages
require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'


## Capistrano tries to backup manifest but there is no assets available.
## So overwrite assets backup task in library do nothing! 
Rake::Task["deploy:assets:backup_manifest"].clear
namespace :deploy do
  namespace :assets do
    task :backup_manifest do
      # no-op to skip backing up the manifest
    end
  end
end

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
