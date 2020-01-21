class CreateRaces < ActiveRecord::Migration[5.2]
    def change 
        create_table :races do |t|
        t.integer :prize
        t.integer :mileage_increase
        t.string :result
        t.integer :user_car1_id
        end
     end
end