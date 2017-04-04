class Kf_nw_kokiri < Character

	def initialize
		super("Kokiri boy", "A Kokiri boy is breaking a sweat while lifting rocks.", "Kokiri", 0, "Kokiri boy", "Kokiri boys")
		@parent_alias = true
		@parent_singular = "boy"
		@parent_plural = "boys"
	end

	def dialogue(game_status)
		return "You can pick up rocks with the command \"pick up <item>\".
Then you can throw them with \"throw <item>\" or drop them with \"drop <item>\".
Mean old Mido... he made me pick up the stones in front of his house."
	end
	
end