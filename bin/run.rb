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
    puts "\u{1f3ce}" 
    puts "Welcome to A/J Raceway!" 
    puts "\u{1f3ce}"
    # render_ascii_art
    puts 
    puts
    puts "PRESS ENTER"
    gets.chomp
    system("clear") 
    run_game  
end 

def run_game
    prompt = TTY::Prompt.new
    log_in = prompt.ask("What is your name?")
    $user = User.all.find{|username|username.name == log_in.upcase}  
        if  $user == nil
            puts "Hi #{log_in}! Here's 100k! Your username has been saved. Use it to log back in next time."
            $user = User.create(name:"#{log_in.upcase!}",balance:100000)
            user = $user
                else
                puts "Welcome back #{$user.name}! You have #{$user.balance}."
                user = $user
                end
                    menu
    end 

def make_choice_meth 
    prompt = TTY::Prompt.new
    car_makes = Car.all.map{|car|car.make}.uniq
    car_makes << "BACK"
    make_choice = prompt.select("#{$user.name}. Please choose a vehicle make.",car_makes)
        if make_choice != "BACK"
            model_choice_meth(make_choice)
                else menu
                    end 
end 
        
def model_choice_meth(make)
            prompt = TTY::Prompt.new
            car_models = Car.all.select{|car| make == car.make}.map{|car| car.model }
            car_models << "BACK"
            model_choice = prompt.select("Pick a model",car_models)
                if model_choice != "BACK"
                    system("clear")
                    return Car.all.find{|car|car.model == model_choice} 
                        else
                        system("clear") 
                        make_choice_meth
                end  
            end 
            
def new_uc(new_car)
    prompt = TTY::Prompt.new
        car_choice = Car.all.find{|car| car.model == new_car.model}
            UserCar.create(condition:100, user_id:$user.id, car_id: car_choice.id, uc_top_speed:car_choice.top_speed)
end 
            
            
#Opens the shop
def shop
    prompt = TTY::Prompt.new
    new_car = make_choice_meth
    new_purchase = new_uc(new_car)
    puts "You purchased a #{new_purchase.car.make} #{new_purchase.car.model}!" 
    menu 
end 
            
# This is the garage 
def garage
    prompt = TTY::Prompt.new
    chosen_vehicle = prompt.select("These are your available vehicles BALANCE: $#{$user.balance}", $user.cars_with_conditions)
        object = $user.cars.find{|car| car.model == chosen_vehicle.split[1]}  
        choices = ["Race", "Fix", "BACK"]
            choice = prompt.select("#{chosen_vehicle}", choices)
                if choice == "Race"
                    race_opponent?(object)
                        # elseif  
                        # fix  
                            else
                                garage      
                                end  
end 
                
#This method is for selecting an opponent
def race_opponent?(your_car)
    prompt = TTY::Prompt.new
    system("clear")
    opponent_choice = make_choice_meth
    puts "CHOOSE YOUR OPPONENT"
    new_race(your_car,opponent_choice)
end 
                
#Gentlemen start your engines
def new_race(car_1,car_2)
    uc = $user.user_cars.find{|current_uc| current_uc.car.model == car_1.model}
    system("clear")
        if uc.condition < 75
            uc.top_speed_nerf
                elsif uc.condition < 50 
                    uc.top_speed_heavy_nerf
                    end      
                        if uc.car.top_speed > car_2.top_speed
                            system("say 'Congratulations #{$user.name} You Won!'") 
                            uc.deteriorate
                            puts "YOU WIN!"
                            menu
                                else 
                                    system("say 'Gotta be quicker than that!'")
                                    uc.deteriorate
                                    puts "Hold this L"
                                    menu
                                    end  
end

#Displays a navigational menu
def menu 
prompt = TTY::Prompt.new
choices = ["Go to Garage", "Open Shop", "Log Out"]
choice = prompt.select("", choices) 
    if choice == choices[0] && $user.user_cars.size > 0               
        system("clear")
        garage
            elsif choice == choices[0] && $user.user_cars.size == 0 
            system("clear")
            puts "You have no cars in your garage. Purchase one from the shop first!"
            menu
                elsif choice == choices[1] 
                system("clear")
                shop
                    else
                    intro 
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

intro 

#user either win/loss and get mieage increase and balance (+) or (-)
#user gets chooses car or buy/sell car 


#GAME EMD
#########################################################################################################################







