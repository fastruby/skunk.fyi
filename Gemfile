source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0.3", ">= 6.0.3.3"

gem "madmin", "~> 1.0.0"

# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 4.1"
# Use SCSS for stylesheets
gem "sass-rails"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"
# Static Pages
gem "high_voltage"

gem "webpacker", "~> 5.x"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :test do
  gem "test-unit"
end

group :development, :test do
  gem "rails_best_practices"
  gem "factory_bot_rails"
  gem "simplecov", require: false
  gem "standard"
  gem "rubocop-rspec"
  gem "rubocop-rails"
  gem "rubocop-ombu_labs", require: false, github: "fastruby/rubocop-ombu_labs", branch: :main
  gem "reek"
  gem "overcommit"
end

gem "dotenv-rails"

gem "bootsnap"
