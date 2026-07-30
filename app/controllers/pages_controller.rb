class PagesController < ApplicationController
  # Replaces high_voltage, which existed to serve a whole directory of static
  # pages by id without touching routes. There is only one page, so the gem was
  # buying nothing and its dynamic template lookup was a public URL surface we
  # never used. The action name resolves to app/views/pages/home.html.erb.
  def home
  end
end
