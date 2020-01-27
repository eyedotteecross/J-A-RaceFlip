class AddStreakToUsers < ActiveRecord::Migration[5.2]
    def change
      add_column :users, :streak, :integer
    end
end