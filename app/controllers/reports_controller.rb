class ReportsController < ApplicationController
  include ReportsHelper

  protect_from_forgery except: [:create]

  DATA_KEY = %W!file skunk_score churn_times_cost churn cost coverage!

  def create
    data = request.body.read
    begin
      input = JSON.parse data
    rescue => err
      logger.fatal("Error: #{err.message} || #{data}")
      head 400
      return
    end

    entries = input["entries"]

    unless entries.is_a? Array
      head 400
      return
    end

    unless (DATA_KEY - entries.first.keys).empty?
      head 400
      return
    end

    rep = Report.create report: JSON.generate(entries)

    options = input["options"] || {}

    if options["compare"]
      rep.compare = true
    end

    rep.save

    render json: {id: rep.short_id}
  end

  def show
    @report = Report.find_from_short_id params[:id]

    fastest = nil
    fastest_val = nil
    note_high_stddev = false

    @report.data.each do |part|
      if !fastest_val || part["ips"] > fastest_val
        fastest = part
        fastest_val = part["ips"]
      end

      if stddev_percentage(part) >= 5
        note_high_stddev = true
      end
    end

    @note_high_stddev = note_high_stddev
    @fastest = fastest
  end
end
