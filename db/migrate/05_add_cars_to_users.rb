class AddStreakToUsers < ActiveRecord::Migration[5.2]
    def change
      add_column :users, :cars, :integer
    end
end