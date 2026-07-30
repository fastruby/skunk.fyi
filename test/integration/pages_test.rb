require "test_helper"

# The root page had no coverage at all, which mattered once it stopped being
# served by high_voltage and started going through PagesController.
class PagesTest < ActionDispatch::IntegrationTest
  def test_root_renders_the_home_page
    get "/"

    assert_equal 200, status
    assert_includes body, "Getting Started"
  end

  # high_voltage registered `GET /pages/*id`, so this URL was live before the gem
  # was removed. Kept as a redirect so external links still resolve.
  def test_the_legacy_page_url_redirects_to_root
    get "/pages/home"

    assert_equal 301, status
    assert_redirected_to "/"
  end
end
