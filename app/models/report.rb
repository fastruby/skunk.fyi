require "digest"

class Report < ActiveRecord::Base
  before_validation :set_slug

  validates :report, length: {minimum: 100, maximum: 20_000}
  validates :slug, uniqueness: true
  validate :validate_parseability

  def data
    JSON.parse report
  end

  private

  def set_slug
    return if slug.present? || report.blank?

    random_report = report + Time.now.to_i.to_s
    self.slug = Digest::SHA2.hexdigest(random_report)
  end

  def validate_parseability
    return if report.blank?

    JSON.parse(report)
  rescue JSON::ParserError
    errors.add :report, :invalid, message: "must be valid JSON"
  end
end
