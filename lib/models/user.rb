class User < ActiveRecord::Base
    has_many :user_cars
    has_many :cars, through: :user_cars



    def cars 
    cars = self.user_cars{|user_car| user_car.user == self}.map{|user_car| user_car.car}
    system("clear")
    cars
    end

    def mapped_cars 
        cars = self.cars.map{|car| "#{car.make} #{car.model} #{car.value}"}
        system("clear")
        cars
        end

    def user_cars 
        UserCar.all.select{|user_car| user_car.user == self}
    end
    
    def add_car(car_id)
    UserCar.create(mileage:0,condition:"Excellent",user_id:self.id,car_id:car_id)
    system("clear")
    return "Car has been added to your garage"
    end 

    def cars_with_conditions
     self.user_cars.map{|uc| "#{uc.car.make} #{uc.car.model} VALUE: #{uc.car.value} CONDITION:%#{uc.condition}"}   
    end 
end