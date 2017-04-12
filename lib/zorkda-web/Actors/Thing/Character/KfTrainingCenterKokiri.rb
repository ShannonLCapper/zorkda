module Zorkda
  module Actors
    
    #DONE
    class KfTrainingCenterKokiri < Character

    	def initialize
    		super("Kokiri boy", "A Kokiri boy stands nearby, throwing punches at the air.", "Kokiri", 0, "Kokiri boy", "Kokiri boys")
    		@parent_alias = true
    		@parent_singular = "boy"
    		@parent_plural = "boys"
    	end

    	def dialogue(game_status)
    		return [
          "Let's talk about some attacks!",
          " ",
          "To use a weapon, type &quot;hit &lt;thing&gt; with &lt;weapon&gt;&quot;.",
          "For your sword, you can also just type &quot;cut &lt;thing&gt;&quot;.",
          " ",
          "For weapons that can shoot, you can also use the command " +
          "&quot;shoot &lt;weapon/ammo&gt; at &lt;thing&gt;&quot;.",
          " ",
          "To avoid attacks, you can use &quot;dodge&quot;. " +
          "If you have a shield equipped, you can also &quot;block&quot;. " +
          "Dodge and block only work if you are actively being attacked.",
          " ",
          "To ask your fairy about the enemies in the room, type &quot;enemy info&quot;.",
          " ",
          "Got all that?"
        ]
    	end

    end

  end
end