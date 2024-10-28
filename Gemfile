source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.5'

gem 'rails', '~> 6.1.6'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'jsbundling-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'devise'
gem 'simple_form', github: 'heartcombo/simple_form'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'simplecov', require: false, group: :test

group :development, :test do
  gem 'dotenv-rails'  # Add this line
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'ffi', '1.15.5'
gem 'pg'
