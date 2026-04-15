class BookingsController < ApplicationController
  before_action :selection_made?
  def new
    @booking = Booking.new
  end

  private

  def booking_params
    params.expect(booking: [:flight, :num_of_passengers])
  end

  def selection_made?
    unless booking_params[:flight].present?
      redirect_back fallback_location: root_path
    end
  end
end
