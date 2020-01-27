class UserCar < ActiveRecord::Base
    belongs_to :user 
    belongs_to :car 
    has_many :races 
    
    def new_balance 
        self.user.balance -= self.car.value
        self.user.num_cars += 1
        self.user.save
        self.save
    end 
    
    def fix(car)
        self.user.balance -= self.car.value * self.condition/1111 
        self.condition = 100
        self.uc_top_speed = self.car.top_speed
        self.user.save
        self.save
    end 

    def sell(car)
        self.user.balance += self.car.value * self.condition/100
        self.user.num_cars -= 1
        self.user.save
        self.delete 
    end 

    def top_speed_nerf
        self.uc_top_speed *= (self.condition.to_f/100)
        self.save
    end
    
    def top_speed_heavy_nerf
        self.uc_top_speed *= (self.condition.to_f/120)
        self.save
    end 

    def deteriorate
        self.condition -= 7
        self.save
    end 

    def won(car_1,car_2)
        self.user.balance += (car_2.value * 0.65).to_i
        self.user.wins += 1
        if  self.user.last_desc == "W"
            self.user.W_streak +=1 
            self.user.W_streak 
        else
            self.user.last_desc = "W"
            self.user.W_streak = 1
            self.user.W_streak  
        end
        self.user.save
    end 

    def lost(car_1,car_2)
        self.user.balance -= (car_2.value * 0.65).to_i
        self.user.losses += 1
        if  self.user.last_desc == "L"
            self.user.W_streak +=1 
            self.user.W_streak 
        else
            self.user.last_desc = "L"
            self.user.W_streak = 1
            self.user.W_streak  
        end 
        self.user.save
    end 

    def apply_upgrade(upgrade)
    
    end 
    
    def sell_upgrade(upgrade) 

    end 
end