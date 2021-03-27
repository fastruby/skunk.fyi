require "test_helper"

class ReportShowTest < ActionDispatch::IntegrationTest
  def test_slug
    data = <<~DATA
      [{
        "file": "lib/skunk/cli/commands/version.rb",
        "skunk_score": 8.8,
        "churn_times_cost": 0.44,
        "churn": 5,
        "cost": 0.09,
        "coverage": 0.0
      }]
    DATA

    report = Report.create report: data

    get "/#{report.slug}"
    assert_equal 200, status
  end
end
