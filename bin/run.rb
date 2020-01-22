require_relative'../config/environment'
# require'tty-prompt'
# require'pry'

prompt = TTY::Prompt.new

system("clear")
#welcome Message
puts "Welcome to A/J Raceway"
gets.chomp

#user signs in with name
user_name = prompt.ask("What is your name?")
user = User.create(name:"#{user_name}",balance:100000,cars:[])
system("clear")

#user chooses a car from all cars
car_makes = Car.all.map{|car|car.make}.uniq
system("clear")
a = prompt.select("Hi #{user.name}. Please choose a vehicle make.",car_makes)
system("clear")
car_model = Car.all.select{|car| a == car.make}.map{|car|car.model}
system("clear")
b = prompt.select("Pick a model",car_model)
system("clear")


# puts "Welcome to your garage #{user_name}"
# n/
# n/
# puts 
#user gets to choose racer/car to race

#user either win/loss and get mieage increase and balance (+) or (-)

#user goes back to garage and sees cars and condition and balance

#user gets chooses car or buy/sell car 

#user race again








