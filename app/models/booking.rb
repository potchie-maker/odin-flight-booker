class Booking < ApplicationRecord
  has_many :passengers, dependent: :destroy

  belongs_to :flight

  validates :flight, presence: true
  validates :passengers, presence: true

  accepts_nested_attributes_for :passengers
end
