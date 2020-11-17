require "test_helper"

class ReportsControllerTest < ActionController::TestCase
  test "validates the data json" do
    data = "nope"

    post :create, body: data

    assert_equal "400", @response.code
  end

  test "validates the data json as valid skunk data" do
    data = <<-DATA
{
  "entries":
    [{
      "file": "lib/skunk/share.rb",
      "skunk_score": "127.64",
      "churn_times_cost": "2.55",
      "churn": "2",
      "cost": "1.28",
      "coverage": "0.0"
    }],
  "summary": {
    "total_skunk_score": "278.58",
    "analysed_modules_count": "17",
    "skunk_score_average": "16.39",
    "skunk_version": "0.4.2",
    "worst_skunk_score": {
      "file": "lib/skunk/share.rb",
      "skunk_score": "127.64"
    }
  },
  "options": {
    "compare": "false"
  }
}
    DATA

    post :create, body: data

    assert_equal "200", @response.code

    rep = JSON.parse @response.body

    report = Report.find_from_short_id rep["id"]

    raw = <<-DATA
    [{
      "file": "lib/skunk/share.rb",
      "skunk_score": "127.64",
      "churn_times_cost": "2.55",
      "churn": "2",
      "cost": "1.28",
      "coverage": "0.0"
    }]
    DATA

    assert_equal JSON.parse(raw), report.data
  end

  test "errors on unknown data keys" do
<<<<<<< HEAD
    data = <<-DATA
    {
      "entries":
        [{
          "file": "lib/skunk/share.rb",
          "skunk_score": "127.64",
          "churn_times_cost": "2.55",
          "churn": "2",
          "cost": "1.28",
          "coverage": "0.0",
          "foo": "bar"
        }],
      "summary": {
        "total_skunk_score": "278.58",
        "analysed_modules_count": "17",
        "skunk_score_average": "16.39",
        "skunk_version": "0.4.2",
        "worst_skunk_score": {
          "file": "lib/skunk/share.rb",
          "skunk_score": "127.64"
        }
      },
      "options": {
        "compare": "false"
      }
    }
=======
    data = <<~DATA
      {
        "entries":
          [{
            "name": "test",
            "ipx": 10.1,
            "stddev": 0.3,
            "microseconds": 3322,
            "iterations": 221,
            "cycles": 16
          }]
      }
>>>>>>> Fix standardrb Style/StringLiterals
    DATA

    post :create, body: data

    assert_equal "400", @response.code
  end

  test "errors out if there are keys missing" do
<<<<<<< HEAD
    data = <<-DATA
    {
      "entries":
        [{
          "file": "lib/skunk/share.rb",
        }],
      "summary": {
        "total_skunk_score": "278.58",
        "analysed_modules_count": "17",
        "skunk_score_average": "16.39",
        "skunk_version": "0.4.2",
        "worst_skunk_score": {
          "file": "lib/skunk/share.rb",
          "skunk_score": "127.64"
        }
      },
      "options": {
        "compare": "false"
      }
    }
=======
    data = <<~DATA
      {
        "entries":
          [{
            "name": "test"
          }]
      }
>>>>>>> Fix standardrb Style/StringLiterals
    DATA

    post :create, body: data

    assert_equal "400", @response.code
  end
end
