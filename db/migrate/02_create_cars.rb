class CreateCars < ActiveRecord::Migration[5.2]
    def change 
        create_table :cars do |t|
        t.string :make
        t.string :model
        t.integer :value
        t.integer :top_speed
        end
     end
end