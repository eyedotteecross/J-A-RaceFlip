class Car < ActiveRecord::Base
    has_many :user_cars
    has_many :users, through: :user_cars

    def name
        s = "#{self.make} #{self.model}"
        s.gsub!(/\A"|"\Z/, '')
        
    end 
end