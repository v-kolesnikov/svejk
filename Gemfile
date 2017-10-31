# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  "https://github.com/#{repo_name}"
end

gem 'rake'

# Web framework
gem 'dry-system', '>= 0.7.1'
gem 'dry-web', '>= 0.7.0'
gem 'dry-web-roda', '>= 0.6.0'
gem 'puma'
gem 'rack_csrf'

gem 'rack', '>= 2.0'
gem 'shotgun', '>= 0.9.2'

# Database persistence
gem 'pg'
gem 'rom', '~> 4.0'
gem 'rom-sql', '~> 2.0'

# Application dependencies
gem 'dry-matcher'
gem 'dry-monads'
gem 'dry-struct'
gem 'dry-transaction', '>= 0.10.0'
gem 'dry-types'
gem 'dry-validation'
gem 'dry-view', '>= 0.3.0'
gem 'faraday'
gem 'que'
gem 'slim'

gem 'rollbar'

group :development, :test do
  gem 'pry-byebug', platform: :mri
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'simplecov', require: false
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'codeclimate-test-reporter'
  gem 'database_cleaner'
  gem 'dredd_hooks'
  gem 'poltergeist'
  gem 'rom-factory', '~> 0.5.0'
  gem 'rspec'
end
