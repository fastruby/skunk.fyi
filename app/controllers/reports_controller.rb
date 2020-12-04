class ReportsController < ApplicationController
  include ReportsHelper

  protect_from_forgery except: [:create]

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

    rep = Report.create report: JSON.generate(entries)

    options = input["options"] || {}

    if options["compare"]
      rep.compare = true
    end

    rep.save

    render json: {id: rep.slug}
  end

  def show
    @report = Report.find_by slug: params[:id]
  end
end
