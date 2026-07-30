require "test_helper"

# Smoke tests for the madmin admin panel. Madmin generates its controllers and
# renders its views out of the gem, so an upgrade can break the admin without
# touching a single file in this repo. These tests only assert that each screen
# renders, which is what we need in order to notice.
class MadminTest < ActionDispatch::IntegrationTest
  def setup
    @report = Report.create!(report: file_fixture_body)
    @analyzed_file = AnalyzedFile.create!(
      report: @report,
      name: "lib/skunk/commands/status_sharer.rb",
      skunk_score: 140.36,
      churn_times_cost: 18.19,
      churn: 7,
      cost: 2.6,
      coverage: 46.81
    )
  end

  def test_requires_basic_auth
    get "/madmin"

    assert_equal 401, status
  end

  def test_dashboard_renders
    get_as_admin "/madmin"

    assert_equal 200, status
  end

  # With nothing configured the panel has to refuse everyone. Comparing unset
  # credentials naively would let an empty username and password through.
  def test_denies_access_when_no_credentials_are_configured
    original = [ ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"] ]
    ENV["ADMIN_USERNAME"] = nil
    ENV["ADMIN_PASSWORD"] = nil

    credentials = ActionController::HttpAuthentication::Basic.encode_credentials("", "")
    get "/madmin", headers: { "HTTP_AUTHORIZATION" => credentials }

    assert_equal 401, status
  ensure
    ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"] = original
  end

  def test_reports_screens_render
    [ "/madmin/reports",
      "/madmin/reports/new",
      "/madmin/reports/#{@report.id}",
      "/madmin/reports/#{@report.id}/edit" ].each do |path|
      get_as_admin path

      assert_equal 200, status, "expected #{path} to render"
    end
  end

  def test_analyzed_files_screens_render
    [ "/madmin/analyzed_files",
      "/madmin/analyzed_files/new",
      "/madmin/analyzed_files/#{@analyzed_file.id}",
      "/madmin/analyzed_files/#{@analyzed_file.id}/edit" ].each do |path|
      get_as_admin path

      assert_equal 200, status, "expected #{path} to render"
    end
  end

  def test_updating_a_report_through_the_admin
    patch "/madmin/reports/#{@report.id}",
      params: { report: { compare: true } },
      headers: admin_headers

    assert_includes 200..399, status
    assert @report.reload.compare
  end

  private

  def get_as_admin(path)
    get path, headers: admin_headers
  end

  def admin_headers
    credentials = ActionController::HttpAuthentication::Basic.encode_credentials(
      ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]
    )

    { "HTTP_AUTHORIZATION" => credentials }
  end

  def file_fixture_body
    <<~DATA
      [{
        "file": "lib/skunk/commands/status_sharer.rb",
        "skunk_score": 140.36,
        "churn_times_cost": 18.19,
        "churn": 7,
        "cost": 2.6,
        "coverage": 46.81
      }]
    DATA
  end
end
