# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'pg'
gem 'rails', '~> 6.1.6'
# Use jdbcpostgresql as the database for Active Record
# gem 'activerecord-jdbcpostgresql-adapter'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'

gem 'rubocop-rails', require: false
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'bunny'

group :development do
  gem 'listen', '~> 3.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
