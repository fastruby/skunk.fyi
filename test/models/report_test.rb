require "test_helper"

class ReportTest < ActionController::TestCase
  test "creation sets a slug for the report record" do
    data = file_fixture("valid_report.json").read
    report = Report.create(report: data)

    assert_equal 64, report.slug.size
  end

  test "creation creates files in the database" do
    data = file_fixture("valid_report.json").read
    report = Report.create(report: data)

    assert_equal 17, report.analyzed_files.size
  end

  test "it is invalid when report is too short" do
    msg = "Report is too short (minimum is 100 characters)"
    report = Report.new

    assert report.invalid?
    assert_equal msg, report.errors.full_messages.first
  end

  test "it is invalid when report is too big" do
    msg = "Report is too long (maximum is 20000 characters)"
    data = (1..20_000).map { rand(10000).to_s }.join
    report = Report.new(report: data)

    assert report.invalid?
    assert_includes msg, report.errors.full_messages.join(", ")
  end

  test "it is invalid when report is not valid JSON" do
    msg = "Report must be valid JSON"
    data = file_fixture("invalid_report.json").read
    report = Report.new(report: data)

    assert report.invalid?
    assert_equal msg, report.errors.full_messages.first
  end

  test "it is valid when report has a report payload within the limits" do
    data = file_fixture("valid_report.json").read
    report = Report.new(report: data)

    assert report.valid?
  end
end
