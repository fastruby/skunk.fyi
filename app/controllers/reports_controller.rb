class ReportsController < ApplicationController
  include ReportsHelper

  protect_from_forgery :except => [:create]

  def create
    data = request.body.read
    begin
      input = JSON.parse data
    rescue Exception => err
      logger.fatal("Error: #{err.message} || #{data}")
      head 400
      return
    end

    ary = input["entries"]

    unless ary.kind_of? Array
      head 400
      return
    end

    ary.each do |j|
      needed = AnalyzedModule::KEYS.dup

      j.keys.each do |k|
        if AnalyzedModule::KEYS.include? k
          needed.delete k
        else
          head 400
          return
        end
      end

      unless needed.empty?
        head 400
        return
      end
    end

    rep = Report.create report: JSON.generate(ary)

    options = input["options"] || {}

    if options["compare"]
      rep.compare = true
    end

    rep.save

    render json: { id: rep.short_id }
  end

  def show
    @report = Report.find_from_short_id params[:id]
  end
end
