require "test_helper"

class PagesTest < ActionDispatch::IntegrationTest
  def test_root_renders_the_home_page
    get "/"

    assert_equal 200, status
    assert_includes body, "Getting Started"
  end

  # This URL was live historically; kept as a redirect for external links.
  def test_the_legacy_page_url_redirects_to_root
    get "/pages/home"

    assert_equal 301, status
    assert_redirected_to "/"
  end
end
