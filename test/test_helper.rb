ENV["RAILS_ENV"] ||= "test"

# The madmin panel authenticates with HTTP basic auth built from these, and
# `http_basic_authenticate_with` raises when they are nil, so the admin tests need
# them to come from somewhere. Set here rather than in a committed .env.test so
# that nothing credential-shaped lives in the repo, and set before the
# environment is loaded because Madmin::ApplicationController reads them at
# class-definition time.
ENV["ADMIN_USERNAME"] ||= "test-admin"
ENV["ADMIN_PASSWORD"] ||= "test-password"

require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
