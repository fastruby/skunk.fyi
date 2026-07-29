class ReportsController < ApplicationController
  include ReportsHelper

  protect_from_forgery except: [ :create ]

  def create
    data = raw_report_body
    input = JSON.parse data

    entries = input["entries"]
    project = find_project(input)

    unless entries.is_a? Array
      head :bad_request
      return
    end

    entries.each do |j|
      needed = AnalyzedModule::KEYS.dup

      j.keys.each do |k|
        if AnalyzedModule::KEYS.include? k
          needed.delete k
        else
          head :bad_request
          return false
        end
      end

      unless needed.empty?
        head :bad_request
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
    head :bad_request
    nil
  end

  def show
    @report = Report.find_by slug: params[:id]

    if @report.blank?
      render file: Rails.root.join("public/404.html"), layout: false, status: :not_found
    end
  end

  private

  # The report is a raw JSON document, not form parameters, so it has to be read
  # off the request instead of out of `params`.
  #
  # Clients that send `Content-Type: application/json` are straightforward:
  # Rails' JSON parameter parser reads the body through `request.raw_post`, which
  # caches it, so `request.body` stays readable in the action.
  #
  # Clients that omit that header get the body parsed as a form instead. Rack 2
  # rewound `rack.input` after parsing, so reading the body here still worked.
  # Rack 3 (pulled in by Rails 7.1) does not rewind, and the params are always
  # read before the action runs by the `start_processing.action_controller` log
  # subscriber, so the stream arrives at EOF and reads as an empty string. Rack
  # does keep the raw string it parsed, so fall back to that.
  def raw_report_body
    body = request.body.read
    return body if body.present?

    request.get_header("rack.request.form_vars").to_s
  end

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
      { id: report.slug, project_id: report.project_id }
    else
      { id: report.slug }
    end
  end
end
