# frozen_string_literal: true

require 'bundler/setup'
require 'byebug' unless ENV['RACK_ENV'] == 'production'
require 'rom/sql/rake_task'
require 'shellwords'
require_relative 'system/svejk/container'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new :spec
  task default: [:spec]
rescue LoadError
  nil
end

def db
  Svejk::Container['persistence.db']
end

def settings
  Svejk::Container['settings']
end

def database_uri
  require 'uri'
  URI.parse(settings.database_url)
end

def postgres_env_vars(uri)
  {}.tap do |vars|
    vars['PGHOST'] = uri.host
    vars['PGPORT'] = uri.port if uri.port
    vars['PGUSER'] = uri.user if uri.user
    vars['PGPASSWORD'] = uri.password if uri.password
  end
end

namespace :worker do
  task :setup do
    require_relative 'apps/worker/system/boot'
  end

  task run: :setup do
    Worker::Application.configure
    Worker::Application.new.run
  end
end

namespace :db do
  task :setup do
    Svejk::Container.start :rom
  end

  task :settings do
    Svejk::Container.start :settings
  end

  task console: :settings do
    system("psql #{Shellwords.escape(database_uri)}")
  end

  desc 'Print current database schema version'
  task version: :setup do
    version =
      if db.tables.include?(:schema_migrations)
        db[:schema_migrations].order(:filename).last[:filename]
      else
        'not available'
      end

    puts "Current schema version: #{version}"
  end

  desc 'Create database'
  task create: :settings do
    if system('which createdb', out: File::NULL)
      uri = database_uri
      env = postgres_env_vars(uri)
      system(env, "createdb #{Shellwords.escape(uri.path[1..-1])}")
    else
      puts 'You must have Postgres installed to create a database'
      exit 1
    end
  end

  desc 'Drop database'
  task drop: :settings do
    if system('which dropdb', out: File::NULL)
      uri = database_uri
      env = postgres_env_vars(uri)
      system(env, "dropdb #{Shellwords.escape(uri.path[1..-1])}")
    else
      puts 'You must have Postgres installed to drop a database'
      exit 1
    end
  end

  desc 'Migrate database up to latest migration available'
  task :migrate do
    # Enhance the migration task provided by ROM

    # Once it finishes, dump the db structure
    Rake::Task['db:structure:dump'].execute

    # And print the current migration version
    Rake::Task['db:version'].execute
  end

  namespace :structure do
    desc 'Dump database structure to db/structure.sql'
    task :dump do
      if system('which pg_dump', out: File::NULL)
        uri = database_uri
        env = postgres_env_vars(uri)
        system(env, "pg_dump -s -x -O #{Shellwords.escape(uri.path[1..-1])}",
               out: 'db/structure.sql')
      else
        puts 'You must have pg_dump installed to dump the database structure'
      end
    end
  end

  desc 'Load seed data into the database'
  task :seed do
    seed_data = File.join('db', 'seed.rb')
    load(seed_data) if File.exist?(seed_data)
  end

  desc 'Load a small, representative set of data to DB (for development)'
  task :sample_data do
    sample_data = File.join('db', 'sample_data.rb')
    load(sample_data) if File.exist?(sample_data)
  end
end
