class User < ActiveRecord::Base
    has_many :user_cars
    has_many :cars, through: :user_cars

    def cars 
        cars = self.user_cars{|user_car| user_car.user == self}.map{|user_car| user_car.car}
        cars
    end

    def mapped_cars 
        cars = self.cars.map{|car| "#{car.make} #{car.model} #{car.value}"}
        cars
        end

    def user_cars 
        UserCar.all.select{|user_car| user_car.user == self}
    end
    
    def add_car(car_id)
        UserCar.create(mileage:0,condition:100,user_id:self.id,car_id:car_id)
        return "Car has been added to your garage"
    end 

    def cars_with_conditions
        self.user_cars.map{|uc| "#{uc.car.make} #{uc.car.model} VALUE: $#{uc.car.value * uc.condition/100} CONDITION:%#{uc.condition}"}   
    end 

    def self.leaderboard(stat)
        system("clear")
            if stat == "Wins"
                # User.find :all, :select => “id, name”
                tp self.all.order(wins: :DESC).limit(15), :id, :name, :wins
                puts "\nPRESS ENTER TO GO BACK"
            elsif stat == "Balance"
                tp self.all.order(balance: :DESC).limit(15), :id, :name, :balance
                puts "\nPRESS ENTER TO GO BACK"
            elsif stat == "Cars"
                tp self.all.order(num_cars: :DESC).limit(15), :id, :name, :num_cars
                puts "\nPRESS ENTER TO GO BACK"
            elsif stat == "W_streak"
                tp self.all.order(W_streak: :DESC).limit(15), :id, :name, :W_streak
                puts "\nPRESS ENTER TO GO BACK"    
            end
    end 

end