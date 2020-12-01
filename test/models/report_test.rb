require 'test_helper'

class ReportTest < ActionController::TestCase
  test "valid? returns false when report is too short" do
    msg = "Report is too short (minimum is 100 characters)"
    report = Report.new

    assert_not report.valid?
    assert_equal msg, report.errors.full_messages.first
  end

  test "valid? returns false when report is too big" do
    msg = "Report is too long (maximum is 20000 characters)"
    data = (1..20_000).map { rand(10000).to_s }.join
    report = Report.new(report: data)

    assert_not report.valid?
    assert_equal msg, report.errors.full_messages.first
  end

  test "valid? returns false when report is not valid JSON" do
    msg = "Report must be valid JSON"
    data = file_fixture('invalid_report.json').read
    report = Report.new(report: data)

    assert_not report.valid?
    assert_equal msg, report.errors.full_messages.first
  end

  test "valid? returns true when report is valid" do
    data = file_fixture('valid_report.json').read
    report = Report.new(report: data)

    assert report.valid?
  end
end