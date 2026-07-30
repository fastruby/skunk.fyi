def next?
  File.basename(__FILE__) == "Gemfile.next"
end

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.12"

if next?
  gem "rails", "~> 7.1.0"
else
  gem "rails", "~> 7.0.0"
end

gem "madmin"

gem "ostruct" # madmin builds every resource attribute with `OpenStruct.new` but never requires "ostruct"

gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 6.0"
gem "sass-rails"

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
end

gem "tzinfo-data", platforms: [ :mingw, :mswin, :x64_mingw, :jruby ]

group :test do
  # minitest 6 requires Ruby >= 3.2, so it only became reachable with the Ruby
  # 3.3 bump. It removes the 3-arg Minitest::Test.run that railties 6.1/7.0 call,
  # which breaks the suite. Rails must move past 7.0 before this pin can go.
  gem "minitest", "~> 5.0"
end

group :development, :test do
  gem "rubocop-rails-omakase", require: false
end

gem "dotenv-rails"

# Rails < 7.1 relies on concurrent-ruby requiring "logger" for us, which it
# stopped doing in 1.3.5 (ActiveSupport::LoggerThreadSafeLevel references
# ::Logger). Unpin once the app is on Rails 7.1+.
gem "concurrent-ruby", "< 1.3.5"

gem "bootsnap"
