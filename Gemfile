def next?
  File.basename(__FILE__) == "Gemfile.next"
end

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: ".tool-versions"

gem "rails", "~> 8.1.0"

gem "madmin"
gem "ostruct" # madmin builds every resource attribute with `OpenStruct.new` but never requires "ostruct"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 7.2"
gem "sass-rails"
gem "dotenv-rails"
gem "fastruby-styleguide", github: "fastruby/styleguide", ref: "ba6522445965914f94497dbe51bf145713b6d656"

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
end

group :development, :test do
  gem "rubocop-rails-omakase", require: false
end

gem "tzinfo-data", platforms: [ :mingw, :mswin, :x64_mingw, :jruby ]
