module Madmin
  class ApplicationController < Madmin::BaseController
    before_action :authenticate_admin

    private

    # Reads the credentials per request rather than through
    # http_basic_authenticate_with, which reads ENV when the class is defined and
    # raises ArgumentError on nil. That turned a missing variable into a boot
    # failure for anything that eager loads (`rails runner`, `rails console`, or
    # any environment with CI set) instead of simply refusing access.
    #
    # Fails closed: with nothing configured, no request can authenticate.
    def authenticate_admin
      authenticate_or_request_with_http_basic("Admin") do |name, password|
        expected_name = ENV["ADMIN_USERNAME"].to_s
        expected_password = ENV["ADMIN_PASSWORD"].to_s

        next false if expected_name.empty? || expected_password.empty?

        # Single & so the comparison does not short circuit on the username.
        ActiveSupport::SecurityUtils.secure_compare(name.to_s, expected_name) &
          ActiveSupport::SecurityUtils.secure_compare(password.to_s, expected_password)
      end
    end
  end
end
