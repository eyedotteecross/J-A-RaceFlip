class CreateRaces < ActiveRecord::Migration[5.2]
    def change 
        create_table :races do |t|
        t.integer :prize
        t.string :result
        t.integer :user_id 
        end
     end
end