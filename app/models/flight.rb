class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"

  validates :departure_airport, presence: true
  validates :arrival_airport, presence: true
  validates :start_datetime, presence: true
  validates :flight_duration, presence: true


  def self.get_flights_from_search(dep_ap_code, arr_ap_code, start_date)
    # Flight.where(departure_airport: Airport.find_by(airport_code: dep_ap_code))
    #   .or(Flight.where(arrival_airport: Airport.find_by(airport_code: arr_ap_code)))
    #   .or(Flight.where(start_datetime: start_date)).order("departure_airport_id", "arrival_airport_id")

    # Flight.where("departure_airport_id = ? OR arrival_airport_id = ? OR start_datetime = ?",
    #              Airport.find_by(airport_code: dep_ap_code), Airport.find_by(airport_code: arr_ap_code), start_date)

    search_results = {}
    # this method of saving the options in a hash allows me to order the results based on more important criteria
    search_results[:by_dep_airport] = Flight.where(departure_airport: Airport.find_by(airport_code: dep_ap_code))
    search_results[:by_arr_airport] = Flight.where(arrival_airport: Airport.find_by(airport_code: arr_ap_code))
    search_results[:by_start_date] = Flight.where(start_datetime: start_date)

    return search_results
  end

# Source - https://stackoverflow.com/a/15721423
# Posted by Luís Ramalho
# Retrieved 2026-04-09, License - CC BY-SA 3.0

  def start_datetime_formatted
    start_datetime.strftime("%m/%d/%Y")
  end
end
