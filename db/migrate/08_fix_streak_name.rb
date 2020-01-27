class FixStreakName < ActiveRecord::Migration[5.2]
    def change
      rename_column :users, :streak, :W_streak
    end
  end