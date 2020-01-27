class AddLastDescToUsers < ActiveRecord::Migration[5.2] 
    def change
      add_column :users, :last_desc, :string
    end
end 
