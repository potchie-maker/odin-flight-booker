class AddIndexToAirports < ActiveRecord::Migration[8.1]
  def change
    add_index :airports, :airport_code, unique: true
  end
end
