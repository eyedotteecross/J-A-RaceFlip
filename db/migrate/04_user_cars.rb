class UserCars < ActiveRecord::Migration[5.2]
    def change 
        create_table :user_cars do |t|
        t.integer :condition
        t.integer :user_id
        t.integer :car_id
        t.integer :uc_top_speed 
        end
    end
end