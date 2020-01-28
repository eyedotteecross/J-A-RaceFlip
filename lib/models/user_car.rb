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

    def speed_adjust
        nerf_or_buff_force = self.condition * 0.01
        self.uc_top_speed *= nerf_or_buff_force
        self.save
        # binding.pry
        if self.condition < 100 && self.condition >= 95
            self.uc_top_speed = rand(self.uc_top_speed + 10..self.uc_top_speed + 20)
        elsif self.condition < 95 && self.condition >= 85
            self.uc_top_speed = rand(self.uc_top_speed + 20..self.uc_top_speed + 30)
        elsif self.condition < 85 && self.condition >= 75 
            self.uc_top_speed = rand(self.uc_top_speed + 30..self.uc_top_speed + 40)
        elsif self.condition < 75 && self.condition >= 60 
            self.uc_top_speed = rand(self.uc_top_speed + 40..self.uc_top_speed + 50)
        elsif self.condition <= 60
            self.uc_top_speed = rand(self.uc_top_speed+ 50..self.uc_top_speed + 75)
        end
    end 

    def deteriorate
        self.condition -= rand(2...8)
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