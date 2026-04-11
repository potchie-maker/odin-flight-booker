class FlightsController < ApplicationController
  def index
    @departure_options = Flight.all.map{ |f| f.departure_airport.airport_code }.uniq
    @arrival_options = Flight.all.map{ |f| f.arrival_airport.airport_code }.uniq
    @date_options = Flight.all.map{ |f| [f.start_datetime_formatted, f.start_datetime] }.uniq

    search_params = flight_search_params
    unless search_params.empty?
      @searched_flights = Flight.where(departure_airport: Airport.find_by(airport_code: search_params[:departure_airport]))
    end
  end

  private

  # this isn't technically necessary, since strong params are really only for assignment(create/update)
  # so I can safely just access these directly from params
  def flight_search_params
    params.permit(:departure_airport, :arrival_airport, :num_of_passengers, :start_datetime, :commit)
  end
end
