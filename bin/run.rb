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
user = User.create(name:"#{user_name}",balance:100000,cars:[])
system("clear")

#user chooses a car from all cars
car_makes = Car.all.map{|car|car.make}.uniq
system("clear")
make_choice = prompt.select("Hi #{user.name}. Please choose a vehicle make.",car_makes)
system("clear")
car_models = Car.all.select{|car| make_choice == car.make}.map{|car|car.model}
system("clear")
model_choice = prompt.select("Pick a model",car_models)
system("clear")
# user.cars << Car.all.find{|car| model_choice == car.model}
UserCar.create(mileage:0, condition:"Excellent", user_id:user.id, car_id:user.cars.last.id)
system("clear")

binding.pry

# puts "Welcome to your garage #{user_name}"
# n/
# n/
# puts 

def garage
prompt.select("These are your available vehicles", user.cars.map{|car| "#{car.make} #{car.model} value:$#{car.value}"})
end 
#user gets to choose racer/car to race

#user either win/loss and get mieage increase and balance (+) or (-)

#user goes back to garage and sees cars and condition and balance

#user gets chooses car or buy/sell car 

#user race again








