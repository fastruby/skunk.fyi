require "test_helper"

# Exercises POST /reports through the full middleware stack. The controller-level
# tests in test/controllers/reports_controller_test.rb bypass Rack, so they can't
# catch bugs that come from how the body is parsed on its way to the action.
class ReportsCreateTest < ActionDispatch::IntegrationTest
  PAYLOAD = {
    "entries" => [
      {
        "file" => "lib/skunk/commands/status_sharer.rb",
        "skunk_score" => 140.36,
        "churn_times_cost" => 18.19,
        "churn" => 7,
        "cost" => 2.6,
        "coverage" => 46.81
      }
    ],
    "summary" => {
      "total_skunk_score" => 140.36,
      "analysed_modules_count" => 1,
      "skunk_score_average" => 140.36,
      "skunk_version" => "0.5.4"
    },
    "options" => { "compare" => "false" }
  }.freeze

  # What the skunk CLI sends: Skunk::Command::StatusSharer#post_payload sets
  # `req.content_type = "application/json"`.
  def test_accepts_a_json_body
    post_report "application/json"

    assert_equal 200, status
    assert Report.find_by(slug: JSON.parse(body)["id"])
  end

  # Regression test for the Rack 3 body-rewinding change.
  #
  # A client that posts the JSON body without `Content-Type: application/json`
  # gets it parsed as a form instead. Rack 2 rewound `rack.input` after doing
  # that, so a later `request.body.read` still saw the whole body. Rack 3 (pulled
  # in by Rails 7.1) does not rewind, so anything that touches `request.params`
  # before the action runs -- the `start_processing.action_controller` log
  # subscriber does, on every request -- leaves the stream at EOF and the action
  # reads an empty string. That surfaced as a 400 with
  # "unexpected end of input at line 1 column 1" in the log.
  def test_accepts_a_json_body_sent_without_a_json_content_type
    post_report "application/x-www-form-urlencoded"

    assert_equal 200, status
    assert Report.find_by(slug: JSON.parse(body)["id"])
  end

  private

  def post_report(content_type)
    post "/reports",
      params: JSON.generate(PAYLOAD),
      headers: { "CONTENT_TYPE" => content_type }
  end
end
