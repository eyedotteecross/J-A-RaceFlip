require_relative'../config/environment'
# require'tty-prompt'
# require'pry'

prompt = TTY::Prompt.new
ActiveRecord::Base.logger.level = 1 


############################################################################################################################
#METHODS
def render_ascii_art
    File.readlines('ascii_art.txt').each do |line|
    puts line
    end 
end

#Welcome Intro
def intro 
    system("clear")
    #welcome Message 
    system("say 'SKIRT SKIRT'") 
    render_ascii_art()
    puts "🏎️" 
    puts "Welcome to A/J Raceway!" 
    puts "🏎️" 
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
    log_in == nil ? run_game() : welcome(log_in)
end 

def user
User.all.find{|user| $user.id == user.id}
end 

def make_choice_meth(game_env,car_object=nil) 
    prompt = TTY::Prompt.new
    shop_makes = Car.all.map{|car|car.make}.uniq << "EXIT SHOP"
    race_makes = Car.all.map{|car|car.make}.uniq.push("SWITCH YOUR VEHICLE", "BACK TO MAIN MENU")
    if game_env == "shop"
        puts "WELCOME TO THE SHOP! Balance:$#{user.balance} \n\n\n"
        make_choice = prompt.select("#{user.name} Please choose a vehicle make to see models available.",shop_makes)
        if make_choice != "EXIT SHOP" 
            # system("clear") 
            model_choice_meth(make_choice,"shop")
        else
            system("clear")  
            menu()
        end 
    end
    if game_env == "race"
        puts "#{car_object} Race 🏁"     
        puts "CHOOSE YOUR OPPONENT"
        puts "#{user.name} Record:#{user.wins}-#{user.losses} BALANCE:$#{user.balance} \n\n\n"
        make_choice = prompt.select("#{user.name} Choose your opponent vehicle's make.",race_makes)
        if make_choice != "SWITCH YOUR VEHICLE" 
            system("clear") 
            model_choice_meth(make_choice,"race",car_object) 
        elsif make_choice == "SWITCH YOUR VEHICLE"
            system("clear")  
            race_meth()
        elsif make_choice == "BACK TO MAIN MENU"
            menu()
        end     
    end 
end 
        
def model_choice_meth(make,game_env,car_object=nil)
    prompt = TTY::Prompt.new
    shop_models = Car.all.select{|car| make == car.make}.map{|car| "#{car.model} PRICE:$#{car.value}"}.push("BACK","EXIT SHOP")
    race_models = Car.all.select{|car| make == car.make}.map{|car| "#{car.model} PRIZE:$#{(car.value * 0.65).to_i}"}.push("BACK","SWITCH YOUR VEHICLE","BACK TO MAIN MENU")
    if game_env == "shop" 
        model_choice = prompt.select("What model would you like?", shop_models)
        if model_choice != "BACK" && model_choice != "EXIT SHOP"
            # system("clear")
            car_choice= Car.all.find{|car|car.model + " PRICE:$#{car.value}" == model_choice}
            # binding.pry
            if user.balance < car_choice.value
                puts "You do not have enough money to buy this car"
                gets.chomp
                shop()
            else  
                new_purchase = new_uc(car_choice)
                new_purchase.new_balance()                
                puts "You purchased a #{new_purchase.car.make} #{new_purchase.car.model}! Your balance is $#{new_purchase.user.balance}" 
            end   
        elsif model_choice == "BACK"
            system("clear") 
            make
            make_choice_meth("shop",car_object)
        elsif 
            system("clear") 
            menu()
        end 
    end  
    if game_env == "race" 
        puts "#{car_object} Race 🏁"  
        model_choice = prompt.select("Pick your opponent vehicle's model", race_models)
        # binding.pry
        if model_choice != "BACK" && model_choice != "SWITCH YOUR VEHICLE" && model_choice != "BACK TO MAIN MENU"
            system("clear")
            return Car.all.find{|car|car.model + " PRIZE:$#{(car.value * 0.65).to_i}" == model_choice} 
        elsif model_choice == "BACK"
            system("clear")
            make 
            make_choice_meth("race",car_object)
        elsif model_choice == "SWITCH YOUR VEHICLE"
            system("clear")
            race_meth()
        elsif model_choice == "BACK TO MAIN MENU"
            system("clear")
            menu()
        end 
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
    car_choice = make_choice_meth("shop")
    #  binding.pry
    # if user.balance < car_choice.value
    #     puts "You do not have enough money to buy this car"
    #     gets.chomp
    #     shop()
    # else  
    #     new_purchase = new_uc(car_choice)
    #     new_purchase.new_balance()                
    #     puts "You purchased a #{new_purchase.car.make} #{new_purchase.car.model}! Your balance is $#{new_purchase.user.balance}" 
    # end 
    menu() 
end 
            
# This is the garage 
def garage
    prompt = TTY::Prompt.new
    puts "#{user.name} Record:#{user.wins}-#{user.losses} BALANCE:$#{user.balance} Cars Owned:#{user.num_cars} \n\n\n"
    your_vehicles = user.cars_with_conditions << "EXIT GARAGE"
    chosen_vehicle = prompt.select("These are your available vehicles:", your_vehicles)
    if chosen_vehicle == "EXIT GARAGE"
        system("clear")
        menu()
    else     
        car_object = user.cars.find{|car| car.model == chosen_vehicle.split[1]}
        uc_object = user.user_cars.find{|ucar| ucar.car == car_object}  
        system("clear")
        choices = ["Fix 🔧 -$#{car_object.value * uc_object.condition/1111}", "Sell 💸 +$#{car_object.value * uc_object.condition/100}", "BACK"]
        choice = prompt.select("#{chosen_vehicle}", choices)
        if  choice == "Fix 🔧 -$#{car_object.value * uc_object.condition/1111}"
            repair_cost = "#{car_object.value * uc_object.condition/1111}" 
            uc_object.fix(car_object)
            puts "Your vehicle has been repaired. You have been charged $#{repair_cost}"
            puts
            garage()
        elsif choice == "Sell 💸 +$#{car_object.value * uc_object.condition/100}" && user.user_cars.size != 1
            uc_object.sell(car_object)
            garage()
        elsif choice == "Sell 💸 +$#{car_object.value * uc_object.condition/100}" && user.user_cars.size == 1     
            system("clear")
            puts "Nope. You must keep one car in your garage!" 
            garage()               
            else
            system("clear")
            garage()      
        end  
    end 
end 

def race_meth 
    prompt = TTY::Prompt.new
    puts "#{user.name} Record:#{user.wins}-#{user.losses} BALANCE:$#{user.balance} Cars Owned:#{user.num_cars} Win Streak:\n\n\n"
    your_vehicles = user.cars_with_conditions << "BACK TO MAIN MENU"
    chosen_vehicle = prompt.select("Choose your vehicle", your_vehicles)
    if chosen_vehicle == "BACK TO MAIN MENU"
        system("clear")
        menu()
    else     
        car_object = user.cars.find{|car| car.model == chosen_vehicle.split[1]}
        uc_object = user.user_cars.find{|ucar| ucar.car == car_object}  
        system("clear")
        race_opponent?(chosen_vehicle,car_object)
    end
end 

#This method is for selecting an opponent
def race_opponent?(your_car,car_object)
    prompt = TTY::Prompt.new
    # system("clear")
    opponent_choice = make_choice_meth("race",your_car)
    #  binding.pry
    new_race(car_object,opponent_choice)
end 
                
#Gentlemen start your engines
def new_race(car_1,car_2)
    # binding.pry
    uc = user.user_cars.find{|current_uc| current_uc.car.model == car_1.model}
    system("clear")
    if uc.condition < 75
        uc.top_speed_nerf()
    elsif uc.condition < 50 
        uc.top_speed_heavy_nerf()
    end 
    # binding.pry     
    if uc.uc_top_speed > car_2.top_speed
        system("say 'Congratulations #{user.name} You Won!'") 
        puts "#{car_1.make} #{car_1.model} vs #{car_2.make} #{car_2.model}"
puts "                          🚁                        \n          
🏢 🏢 🌴🏦 🏚️ 🏫 🌳 ⛪ 🏥 🏪 🏠🏠🌴 🏤 🌴 🏢 🌳🌳      \n
🚙⁣      🚓      🚓     🚓                                \n
    🚗      🚓   🚓    🚓     🚓                     \n\n\n"
        puts "YOU WIN! \n\n\n$#{(car_2.value * 0.65).to_i} will be added to your balance.😎    Your record is now #{user.wins}-#{user.losses}!" 
        uc.won(car_1,car_2) 
        uc.deteriorate()
        menu()
    else 
        system("say 'Gotta be quicker than that!'")
        puts "#{car_1.make} #{car_1.model} vs #{car_2.make} #{car_2.model}"
        puts "Hold this L. \n\n\nYou lost $#{(car_2.value * 0.65).to_i}.😤    You are now #{user.wins}-#{user.losses}"
        uc.lost(car_1,car_2)
        uc.deteriorate()
        menu()
    end  
end

#Displays a navigational menu
def menu 
    prompt = TTY::Prompt.new
    choices = ["Race🏎️", "Go to Garage🧰", "Open Shop🔑", "Leaderboards📈", "Log Out"]
    choice = prompt.select("", choices) 
    if choice == choices[0] && user.user_cars.size > 0               
        system("clear")
        race_meth() #############RACEMETH
    elsif choice == choices[0] && user.user_cars.size == 0 
        system("clear")
        puts "You have no cars to race. Purchase one from the shop first!"
        menu()
    elsif choice == choices[1] && user.user_cars.size > 0               
        system("clear")
        garage()
    elsif choice == choices[1] && user.user_cars.size == 0 
        system("clear")
        puts "You have no cars in your garage. Purchase one from the shop first!"
        menu()
    elsif choice == choices[2] 
        system("clear")
        shop()
    elsif choice == choices[3]
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
        system("clear")
        menu()                
    end    
end

def render_ascii_art
    File.readlines("lib/ascii_art.txt") do |line|
    puts line
    end
  end


#GAME METHODS END
########################################################################################################################
#GAME

intro()

#GAME END
#########################################################################################################################







