module Zorkda
  module Actors

    #DONE
    class Basic_enemy < Enemy
    	def initialize
    		super("Enemy", "Enemy", "Enemies", 1, "RNG", 0) 
    		@respawn_while_in_room = true
    		@respawn_time = 2
    	end
    end

  end
end