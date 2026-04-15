class BookingsController < ApplicationController
  before_action :selection_made?, only: [:new]
  before_action :set_booking, only: [:show]

  def show
  end

  def new
    @booking = Booking.build(booking_params)
    @booking.num_of_passengers.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.build(booking_params)
    if @booking.save
      redirect_to @booking
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.expect(booking: [:flight_id, :num_of_passengers,
                            passengers_attributes: [[:name, :email]]])
  end

  def set_booking
    @booking = Booking.find(params.expect(:id))
  end

  def selection_made?
    unless booking_params[:flight_id].present?
      redirect_back fallback_location: root_path
    end
  end
end
