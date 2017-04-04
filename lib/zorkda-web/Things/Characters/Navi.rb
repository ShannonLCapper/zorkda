class Navi < Character

	attr_accessor :name, :directives

	def initialize
		super("Navi", "A small white fairy circles your head", "fairy", 0, "fairy", "fairies")
		@directives = [
			"The Great Deku Tree has summoned you! We shouldn't keep him waiting.",
			"We need to help the Great Deku Tree!",
			"I don't know what to say"
		]

	end

	def give_directive(checkpoint)
		print "Navi: "
		stream_dialogue("\"Hey! Listen! ")
		puts "\n"
		stream_dialogue(self.directives[checkpoint])
		puts "\""
	end

	def give_enemy_info(enemies)
		if enemies.length > 0
			puts "Navi: \"Here's what I know about the enemies in the room..."
			enemies_listed_already = []
			enemies.each do |enemy|
				if !enemies_listed_already.include?(enemy.gen_singular)
					puts "\n"
					print "#{enemy.gen_singular[0].capitalize}#{enemy.gen_singular[1..-1]}: #{enemy.navi_description}"
					enemies_listed_already << enemy.gen_singular
				end
			end
			puts "\""
		else
			puts "Navi: \"There aren't any enemies here!\""
		end
	end

	def give_hint(hint)
		print "Navi: \""
		stream_dialogue(hint)
		puts "\""
	end

end