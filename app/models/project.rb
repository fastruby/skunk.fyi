class Project < ActiveRecord::Base
  has_many :reports

  validates :permalink, uniqueness: true
end
