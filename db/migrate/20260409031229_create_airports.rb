class CreateAirports < ActiveRecord::Migration[8.1]
  def change
    create_table :airports do |t|
      t.string :airport_code, null: false

      t.timestamps
    end
  end
end
