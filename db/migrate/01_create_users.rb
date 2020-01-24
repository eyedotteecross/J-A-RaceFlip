class CreateUsers < ActiveRecord::Migration[5.2]
    def change 
        create_table :users do |t|
        t.string :name
        t.integer :balance 
        t.integer :wins
        t.integer :losses
        end
     end
end