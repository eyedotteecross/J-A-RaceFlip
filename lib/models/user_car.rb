class UserCar < ActiveRecord::Base
    belongs_to :user 
    belongs_to :car 
    has_many :races 

    def fix
        self.condition = 100 
        self.user.balance -= self.car.value
        self.save
        
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