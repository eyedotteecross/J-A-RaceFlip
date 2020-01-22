require_relative'../config/environment'
# require'tty-prompt'
# require'pry'

prompt = TTY::Prompt.new

system("clear")
#welcome Message
puts "Welcome to A/J Raceway"
gets.chomp

#user signs in with name
user_name = prompt.ask("what is your name player1")
User.create(name:"#{user_name}",balance:100000,cars:[])

#user chooses a car from all cars
car_makes = Car.all.map{|car|car.make}.uniq
a = prompt.select("What Car do you want",car_makes)
car_model = Car.all.select{|car| a == car.make}.map{|car|car.model}
b = prompt.select("What Model do you want",car_model)

puts "Welcome to your garage #{user_name}"
n/
n/
puts 
#user gets to choose racer/car to race

#user either win/loss and get mieage increase and balance (+) or (-)

#user goes back to garage and sees cars and condition and balance

#user gets chooses car or buy/sell car 

#user race again








