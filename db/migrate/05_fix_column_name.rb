class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :cars, :num_cars
  end
end