class User < ActiveRecord::Base
    has_many :user_cars
    has_many :cars, through: :user_cars

    def cars 
    cars = UserCar.all.select{|user_car| user_car.user == self}.map{|user_car| user_car.car}
    system("clear")
    cars
    end

    def mapped_cars 
        cars = self.cars.map{|car| "#{car.make} #{car.model} #{car.value}"}
        system("clear")
        cars
        end
    
    def add_car(car_id)
    UserCar.create(mileage:0,condition:"Excellent",user_id:self.id,car_id:car_id)
    system("clear")
    return "Car has been added to your garage"
    end 
end