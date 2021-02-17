module Madmin
  class ApplicationController < Madmin::BaseController
    http_basic_authenticate_with(
      name: ENV["ADMIN_USERNAME"],
      password: ENV["ADMIN_PASSWORD"]
    )
  end
end
