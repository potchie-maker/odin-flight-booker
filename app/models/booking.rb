class Booking < ApplicationRecord
  belongs_to :flight

  validates :flight, presence: true
  validates :passengers, presence: true
end
