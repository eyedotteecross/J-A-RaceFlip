class CreateCars < ActiveRecord::Migration[5.2]
    def change 
        create_table :cars do |t|
        t.string :make
        t.string :model
<<<<<<< HEAD
        # t.integer :year
=======
>>>>>>> 8b37795e1ace5eb25885b0d2a363940c6beb6428
        t.integer :value
        end
     end
end