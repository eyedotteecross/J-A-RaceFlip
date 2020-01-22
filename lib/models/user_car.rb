class UserCar < ActiveRecord::Base
    belongs_to :user 
    belongs_to :car 
    has_many :races 



    
end