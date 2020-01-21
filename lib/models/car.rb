class Car < ActiveRecord::Base
    has_many :user_cars
    has_many :users, through: :user_cars
end