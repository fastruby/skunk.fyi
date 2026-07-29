ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

# concurrent-ruby 1.3.5 stopped requiring "logger" itself, which Rails < 7.1
# relied on (ActiveSupport::LoggerThreadSafeLevel references ::Logger).
# Remove this once the app is on Rails 7.1+.
require "logger"

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
