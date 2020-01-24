require_relative'../config/environment'
# require'tty-prompt'
# require'pry'

prompt = TTY::Prompt.new
ActiveRecord::Base.logger.level = 1 


############################################################################################################################
#METHODS

#Welcome Intro
def intro 
    system("clear")
    #welcome Message
    system("say 'SKIRT SKIRT'")
    puts "🏎️" 
    puts "Welcome to A/J Raceway!" 
    puts "🏎️"
    # render_ascii_art
    puts 
    puts
    puts "PRESS ENTER"
    gets.chomp
    system("clear") 
    run_game()  
end 

def run_game
    prompt = TTY::Prompt.new
    def welcome(log_in)
    system("clear")
    $user = User.all.find{|username|username.name == log_in.upcase} 
        if  $user == nil
            puts "Hi #{log_in}! Here's 100k! Your username has been saved. Use it to log back in next time."
                $user = User.create(name:"#{log_in.upcase!}",balance:100000,wins:0,losses:0,num_cars:0)
                    else
                    puts "Welcome back #{$user.name}! You have $#{$user.balance}."
                        end
                        menu()
                            end 
    log_in = prompt.ask("What is your name?")
    log_in == nil ? (puts "You must enter a name", gets.chomp, system("clear"), run_game) : welcome(log_in)
    end 

def user
User.all.find{|user| $user.id == user.id}
end 

def make_choice_meth 
    prompt = TTY::Prompt.new
    car_makes = Car.all.map{|car|car.make}.uniq
    car_makes << "BACK"
    make_choice = prompt.select("#{user.name}. Please choose a vehicle make.",car_makes)
        if make_choice != "BACK"
            model_choice_meth(make_choice)
                else menu()
                    end 
end 
        
def model_choice_meth(make)
            prompt = TTY::Prompt.new
            car_models = Car.all.select{|car| make == car.make}.map{|car| car.model}
            car_models << "BACK"
            model_choice = prompt.select("Pick a model",car_models)
                if model_choice != "BACK"
                    system("clear")
                    return Car.all.find{|car|car.model == model_choice} 
                        else
                        system("clear") 
                        make_choice_meth()
                end  
            end 
            
def new_uc(new_car)
    prompt = TTY::Prompt.new
        car_choice = Car.all.find{|car| car.model == new_car.model}
            UserCar.create(condition:100, user_id:user.id, car_id: car_choice.id, uc_top_speed:car_choice.top_speed)
end 
            
            
#Opens the shop
def shop
    prompt = TTY::Prompt.new
    puts "WELCOME TO THE SHOP! Balance:$#{user.balance}"
    new_car = make_choice_meth
    if user.balance < new_car.value
        puts "You do not have enough money to buy this car"
            gets.chomp
                shop()
                    else  
                        new_purchase = new_uc(new_car)
                        new_purchase.new_balance                
                        puts "You purchased a #{new_purchase.car.make} #{new_purchase.car.model}! Your balance is $#{new_purchase.user.balance}" 
                        end 
                        menu() 
end 
            
# This is the garage 
def garage
    prompt = TTY::Prompt.new
    puts "#{user.name} Record:#{user.wins}-#{user.losses} BALANCE:$#{user.balance}"
        your_vehicles = user.cars_with_conditions << "BACK"
            chosen_vehicle = prompt.select("These are your available vehicles", your_vehicles)
                if chosen_vehicle == "BACK"
                menu()
                else     
                    car_object = user.cars.find{|car| car.model == chosen_vehicle.split[1]}
                    uc_object = user.user_cars.find{|ucar| ucar.car == car_object}  
                        system("clear")
                            choices = ["Race 🏁", "Fix 🔧 -$#{car_object.value/3}", "Sell 💸 +$#{car_object.value * uc_object.condition/100}", "BACK"]
                                choice = prompt.select("#{chosen_vehicle}", choices)
                                    if choice == "Race 🏁"
                                        race_opponent?(car_object)
                                            elsif choice == "Fix 🔧 -$#{car_object.value/3}" 
                                                uc_object.fix(car_object)
                                                    puts "Your vehicle has been repaired. You have been charged $#{car_object.value/3}"
                                                    puts
                                                    garage()
                                                        elsif choice == "Sell 💸 +$#{car_object.value * uc_object.condition/100}" && user.user_cars.size != 1
                                                            uc_object.sell(car_object)
                                                            garage()
                                                                elsif choice == "Sell 💸 +$#{car_object.value * uc_object.condition/100}" && user.user_cars.size == 1     
                                                                    system("clear")
                                                                    puts "Nope. You must keep one car in garage!" 
                                                                    garage()               
                                                                    else
                                                                        system("clear")
                                                                        garage()      
                                                                        end  
                                                                        end 
end 
                
#This method is for selecting an opponent
def race_opponent?(your_car)
    prompt = TTY::Prompt.new
    system("clear")
    puts "CHOOSE YOUR OPPONENT"
    opponent_choice = make_choice_meth
    new_race(your_car,opponent_choice)
end 
                
#Gentlemen start your engines
def new_race(car_1,car_2)
    uc = user.user_cars.find{|current_uc| current_uc.car.model == car_1.model}
    system("clear")
        if uc.condition < 75
            uc.top_speed_nerf
                elsif uc.condition < 50 
                    uc.top_speed_heavy_nerf
                    end      
                        if uc.car.top_speed > car_2.top_speed
                            system("say 'Congratulations #{user.name} You Won!'") 
                            uc.deteriorate
                            $user.won 
                            puts "YOU WIN! Your record is now #{user.wins}-#{user.losses}!" 
                            menu()
                                else 
                                    system("say 'Gotta be quicker than that!'")
                                    uc.deteriorate
                                    $user.lost
                                    puts "Hold this L. You are now #{user.wins}-#{user.losses}"
                                    menu()
                                    end  
end

#Displays a navigational menu
def menu 
prompt = TTY::Prompt.new
choices = ["Go to Garage", "Open Shop", "Leaderboards" , "Log Out"]
choice = prompt.select("", choices) 
    if choice == choices[0] && user.user_cars.size > 0               
        system("clear")
        garage()
            elsif choice == choices[0] && user.user_cars.size == 0 
            system("clear")
            puts "You have no cars in your garage. Purchase one from the shop first!"
            menu()
                elsif choice == choices[1] 
                system("clear")
                shop()
                    elsif choice == choices[2]
                        leaderboards()
                            else
                                intro() 
                                end  
end 

def leaderboards
    prompt = TTY::Prompt.new
    system("clear")

        stats = ["Wins " "🏆","Balance " "💰","Cars " "🏎️","EXIT"]
            stat_to_read = prompt.select("Choose a category",stats).split(" ")[0]
                # binding.pry
                if stat_to_read != "EXIT" 
                    User.leaderboard(stat_to_read)
                        gets.chomp
                        leaderboards() 
                            else
                            menu()                
                                end    
end

# def render_ascii_art
#     File.readlines("lib/ascii_art.txt") do |line|
#       puts line
#     end
#   end


#GAME METHODS END
########################################################################################################################
#GAME

intro()

#GAME EMD
#########################################################################################################################







