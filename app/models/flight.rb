class Flight < ApplicationRecord
  has_many :bookings, dependent: :destroy

  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"

  validates :departure_airport, presence: true
  validates :arrival_airport, presence: true
  validates :start_datetime, presence: true
  validates :flight_duration, presence: true


  def self.get_flights_from_search(dep_ap_code, arr_ap_code, start_date)
    # place results in array in order of criteria importance
    search_results = []

    by_dep_airport = Flight.where(departure_airport: Airport.find_by(airport_code: dep_ap_code))
    by_arr_airport = Flight.where(arrival_airport: Airport.find_by(airport_code: arr_ap_code))
    by_start_date = Flight.where(start_datetime: start_date)

    search_results << by_dep_airport << by_arr_airport << by_start_date

    return search_results.flatten
  end

# Source - https://stackoverflow.com/a/15721423
# Posted by Luís Ramalho
# Retrieved 2026-04-09, License - CC BY-SA 3.0

  def start_datetime_formatted
    start_datetime.strftime("%m/%d/%Y")
  end
end
