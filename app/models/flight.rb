class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"

  validates :departure_airport, presence: true
  validates :arrival_airport, presence: true
  validates :start_datetime, presence: true
  validates :flight_duration, presence: true

  # Source - https://stackoverflow.com/a/15721423
# Posted by Luís Ramalho
# Retrieved 2026-04-09, License - CC BY-SA 3.0

  def start_datetime_formatted
    start_datetime.strftime("%m/%d/%Y")
  end
end
