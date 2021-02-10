class ReportResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :report
  attribute :compare
  attribute :created_at, form: false
  attribute :updated_at, form: false

  # Associations
end
