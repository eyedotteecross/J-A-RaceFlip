class User < ActiveRecord::Base
    has_many :user_cars
    has_many :cars, through: :user_cars

    def cars 
    UserCar.all.select{|user_car| user_car.user == self}.map{|user_car| user_car.car}.map{|car| "#{car.make} #{car.model} value:$#{car.value}"}
    end 
end