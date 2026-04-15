class FlightsController < ApplicationController
  def index
    @departure_options = Flight.all.map{ |f| f.departure_airport.airport_code }.uniq
    @arrival_options = Flight.all.map{ |f| f.arrival_airport.airport_code }.uniq
    @date_options = Flight.all.order(:start_datetime).map{ |f| [f.start_datetime_formatted, f.start_datetime.iso8601(9)] }.uniq
    # To find a method to access the full timestamp, otherwise it doesn't show the subseconds. Since the random
    # dates from the seeds have subseconds, the queries weren't matching or returning any records.
    # Google gemini suggested to use #iso8601, and then specifying the decimal precision,
    # i.e. start_datetime.iso8601(9). It said #inspect is only for debugging (but works technically).
    # Also found you can use #round(n), and Time.at(datetime.to_r).
    # Can also use #strftime("%Y-%m-%d %H:%M:%S.%N") (year has to be first to match db formatting).
    #
    # Maybe adding and accessing via index is the way to go? Like using the index as the selected option instead of the
    # literal date. Seems closer to saving an :id and more straightforwared.

    search_params = flight_search_params
    # assigned search params to a variable because it makes the method only be called once
    # so I THINK that it might offer slightly more efficiency/speed
    # otherwise, I can just access directly from params as I wrote over the private method
    unless search_params.empty?
      @searched_flights = Flight.get_flights_from_search(search_params[:departure_airport],
                                                         search_params[:arrival_airport],
                                                         search_params[:start_datetime])
      @num_of_passengers = search_params[:num_of_passengers]
    end

    @booking = Booking.new
  end

  private

  # this isn't technically necessary, since strong params are really only for assignment(create/update)
  # so I can safely just access these directly from params
  def flight_search_params
    params.permit(:departure_airport, :arrival_airport, :num_of_passengers, :start_datetime, :commit)
  end
end
