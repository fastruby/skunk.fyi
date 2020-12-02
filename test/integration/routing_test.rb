require 'test_helper'

class ReportShowTest < ActionDispatch::IntegrationTest
  def test_slug
    data = <<-DATA
[{
  "name": "test",
  "ips": 10.1,
  "stddev": 0.3,
  "microseconds": 3322,
  "iterations": 221,
  "cycles": 16
}]
    DATA

    report = Report.create! report: data

    get "/#{report.slug}"
    assert_equal 200, status
  end
end
