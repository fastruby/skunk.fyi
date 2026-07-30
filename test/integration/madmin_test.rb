require "test_helper"

# Smoke tests for the madmin admin panel. Madmin generates its controllers and
# renders its views out of the gem, so an upgrade can break the admin without
# touching a single file in this repo.
#
# Each screen test asserts on rendered content, not just the status code. A 200
# with a blank body is still a broken admin, and madmin swallows attribute
# resolution errors (see `test_every_resource_resolves_its_attributes`), so the
# body is the only place some failures show up.
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
    # The navigation renders one link per registered resource, and building those
    # links is what forced madmin to resolve every resource's attributes.
    assert_select "a", text: "Reports"
    assert_select "a", text: "AnalyzedFiles"
  end

  # madmin resolves each `attribute` in a resource against the model, and wraps
  # that in a bare `rescue` that reports any failure as a missing attribute
  # (madmin-1.2.5/lib/madmin/resource.rb:39). A NameError on OpenStruct came out
  # of it as "Madmin couldn't find attribute or association 'name'", which is
  # what took the whole admin down in production while every screen test passed
  # against a bundle where something else happened to require "ostruct".
  #
  # Asserting resolution directly gives that failure a name, and covers
  # resources added later without a screen test of their own.
  def test_every_resource_resolves_its_attributes
    assert_predicate Madmin.resources, :any?, "expected madmin to have resources registered"

    Madmin.resources.each do |resource|
      attributes = resource.attributes

      assert_predicate attributes, :any?, "expected #{resource} to resolve attributes"
    end
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
      assert_select "h1", text: /Report/, message: "expected #{path} to render a heading"
    end
  end

  def test_analyzed_files_screens_render
    [ "/madmin/analyzed_files",
      "/madmin/analyzed_files/new",
      "/madmin/analyzed_files/#{@analyzed_file.id}",
      "/madmin/analyzed_files/#{@analyzed_file.id}/edit" ].each do |path|
      get_as_admin path

      assert_equal 200, status, "expected #{path} to render"
      assert_select "h1", text: /AnalyzedFile/, message: "expected #{path} to render a heading"
    end
  end

  # The index and show screens have to render the record's own attributes, which
  # is where a resource that resolved but rendered nothing would show up.
  def test_screens_render_the_records_attributes
    get_as_admin "/madmin/analyzed_files"

    assert_includes response.body, @analyzed_file.name
    assert_includes response.body, "140.36"

    get_as_admin "/madmin/analyzed_files/#{@analyzed_file.id}"

    assert_includes response.body, @analyzed_file.name
    assert_includes response.body, "140.36"
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
