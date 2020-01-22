require_relative'../config/environment'
# require'tty-prompt'
# require'pry'

prompt = TTY::Prompt.new

system("clear")
#welcome Message
puts "Welcome to A/J Raceway!"
puts 
puts
puts "PRESS ANY KEY TO CONTINUE"
gets.chomp
system("clear")

#user signs in with name
user_name = prompt.ask("What is your name?")
$user = User.create(name:"#{user_name}",balance:100000,cars:[])
user = $user
system("clear")

#user chooses a car from all cars
def car_list
    prompt = TTY::Prompt.new
        car_makes = Car.all.map{|car|car.make}.uniq
        system("clear")
        make_choice = prompt.select("Hi #{$user.name}. Please choose a vehicle make.",car_makes)
        system("clear")
        car_models = Car.all.select{|car| make_choice == car.make}.map{|car|car.model}
        system("clear")
        model_choice = prompt.select("Pick a model",car_models)
        system("clear")
        car_choice = Car.all.find{|car| car.model == model_choice}
        UserCar.create(mileage:0, condition:"Excellent", user_id:$user.id, car_id: car_choice.id)
        system("clear")
end 


def race_opponent?(your_car)
    prompt = TTY::Prompt.new
    car_makes = Car.all.map{|car|car.make}.uniq
    system("clear")
    make_choice = prompt.select("Choose a vehicle to race against",car_makes)
    system("clear")
    car_models = Car.all.select{|car| make_choice == car.make}.map{|car|car.model}
    system("clear")
    model_choice = prompt.select("Pick a model",car_models)
    system("clear")
    opponent_choice = Car.all.find{|car| car.model == model_choice}
    system("clear")
    new_race(your_car, opponent_choice)
    # say "SKRT SKRT"
end 

def new_race(car_1,car_2)
    chosen_model = car_1.split[1]
    current_user_car = $user.user_cars.find{|user_car| chosen_model == user_car.car.model} 
    system("clear")

    if {current_user_car} topspeed >

end 

def garage
    prompt = TTY::Prompt.new
    your_car = prompt.select("These are your available vehicles BALANCE: $#{$user.balance}", $user.mapped_cars)
    system("clear")
    choices = ["Race", "Fix"]
    choice = prompt.select("#{your_car}", choices) 
    if choice == "Race"
        race_opponent?(your_car)
        # else 
        # fix  
    end 
    
end 

car_list
garage 


#user either win/loss and get mieage increase and balance (+) or (-)

#user goes back to garage and sees cars and condition and balance

#user gets chooses car or buy/sell car 

#user race again








