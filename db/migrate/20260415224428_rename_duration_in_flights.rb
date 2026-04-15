class RenameDurationInFlights < ActiveRecord::Migration[8.1]
  def change
    rename_column :flights, :flight_duration, :duration_in_sec
  end
end
