class UserCar < ActiveRecord::Base
    belongs_to :user 
    belongs_to :car 
    has_many :races 
    
    def new_balance 
        self.user.balance -= self.car.value
        self.user.save
        self.save
    end 
    
    def fix(car)
        self.condition = 100 
        self.user.balance -= self.car.value/3
        self.user.save
        self.save
    end 

    def sell(car)
        self.user.balance += self.car.value * self.condition/100
        self.user.save
        self.delete 
    end 

    def top_speed_nerf
        self.uc_top_speed *= (self.condition/50)
        self.save
    end
    
    def top_speed_heavy_nerf
        self.uc_top_speed *= (self.condition/75)
        self.save
    end 

    def deteriorate
        self.condition -= 5
        self.save
    end 
end