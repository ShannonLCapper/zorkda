class Kf_training_center_kokiri < Character

	def initialize
		super("Kokiri boy", "A Kokiri boy stands nearby, throwing punches at the air.", "Kokiri", 0, "Kokiri boy", "Kokiri boys")
		@parent_alias = true
		@parent_singular = "boy"
		@parent_plural = "boys"
	end

	def dialogue(game_status)
		return "Let's talk about some attacks!

To use a weapon, type \"hit <thing> with <weapon>\".
For your sword, you can also just type \"cut <thing>\".

For weapons that can shoot, you can also use the command \"shoot <weapon/ammo> at <thing>\".

To avoid attacks, you can use \"dodge\".
If you have a shield equipped, you can also \"block\".
Dodge and block only work if you are actively being attacked.

To ask your fairy about the enemies in the room, type \"enemy info\".

Got all that?"
	end

end