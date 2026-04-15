class RenamePassengersInBookings < ActiveRecord::Migration[8.1]
  def change
    rename_column :bookings, :passengers, :num_of_passengers
  end
end
