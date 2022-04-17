class ReportsController < ApplicationController
  include ReportsHelper

  protect_from_forgery except: [:create]

  def create
    data = request.body.read
    input = JSON.parse data

    entries = input["entries"]
    project = find_project(input)

    unless entries.is_a? Array
      head 400
      return
    end

    entries.each do |j|
      needed = AnalyzedModule::KEYS.dup

      j.keys.each do |k|
        if AnalyzedModule::KEYS.include? k
          needed.delete k
        else
          head 400
          return false
        end
      end

      unless needed.empty?
        head 400
        return false
      end
    end

    rep = create_report(project, entries)

    options = input["options"] || {}

    if options["compare"]
      rep.compare = true
    end

    rep.save

    render json: response_hash(rep)
  rescue => err
    logger.fatal("Error: #{err.message} || #{data}")
    head 400
    nil
  end

  def show
    @report = Report.find_by slug: params[:id]

    if @report.blank?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end

  private

  def create_report(project, entries)
    if project
      project.reports.create report: JSON.generate(entries)
    else
      Report.create report: JSON.generate(entries)
    end
  end

  def find_project(input)
    return if input["project"].blank?

    if input["project"]["id"]
      Project.find(input["project"]["id"])
    elsif input["project"]["permalink"]
      Project.find_or_create_by(permalink: input["project"]["permalink"])
    end
  end

  def response_hash(report)
    if report.project.present?
      {id: report.slug, project_id: report.project_id}
    else
      {id: report.slug}
    end
  end
end
