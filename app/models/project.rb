class Project < ApplicationRecord
  has_many :reports, dependent: :destroy

  validates :permalink, uniqueness: true
end
