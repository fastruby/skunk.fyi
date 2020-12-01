require "digest"

class Report < ActiveRecord::Base
  before_create :set_slug

  validates :report, length: { minimum: 100, maximum: 20_000 }
  validate :validate_parseability

  def data
    JSON.parse report
  end

  private

  def set_slug
    random_report = report + rand(1_000).to_s
    self.slug = Digest::SHA2.hexdigest(random_report)
  end

  def validate_parseability
    return if report.blank?

    JSON.parse(report)

  rescue JSON::ParserError
    self.errors.add :report, :invalid, message: "must be valid JSON"
  end
end
