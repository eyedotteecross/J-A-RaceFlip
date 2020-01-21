class UserCars < ActiveRecord::Migration[5.2]
    def change 
        create_table :user_cars do |t|
        t.integer :mileage
        t.string :condition
        t.integer :user_id
        t.integer :car_id
        end
    end
end