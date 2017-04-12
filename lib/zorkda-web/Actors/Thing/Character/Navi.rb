module Zorkda
  module Actors
    
    #DONE
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
				text_lines = [
					"Navi: &quot;Hey! Listen!",
					self.directives[checkpoint] + "&quot;"
				]
				Zorkda::GameOutput.add_lines(text_lines)
			end

			def give_enemy_info(enemies)
				if enemies.length > 0
					text_lines = ["Navi: &quot;Here's what I know about the enemies in the room..."]
					enemies_listed_already = []
					enemies.each do |enemy|
						if !enemies_listed_already.include?(enemy.gen_singular)
							text_lines << "#{enemy.gen_singular[0].capitalize}#{enemy.gen_singular[1..-1]}: #{enemy.navi_description}"
							enemies_listed_already << enemy.gen_singular
						end
					end
					text_lines[-1] += "&quot;"
					Zorkda::GameOutput.add_lines(text_lines)
				else
					Zorkda::GameOutput.add_line("Navi: &quot;There aren't any enemies here!&quot;")
				end
			end

			def give_hint(hint)
				Zorkda::GameOutput.add_line("Navi: &quot;#{hint}&quot;")
			end

		end

	end
end