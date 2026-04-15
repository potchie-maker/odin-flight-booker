class RemoveIndexFromPassengers < ActiveRecord::Migration[8.1]
  def change
    remove_index :passengers, :email
  end
end
