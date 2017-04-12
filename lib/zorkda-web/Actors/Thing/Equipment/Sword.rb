module Zorkda
	module Actors

    #DONE
		class Sword < Equipment

      attr_accessor :uses, :total_uses

      def initialize(name, damage_enemy, gen_singular, gen_plural, total_uses)
        super(name, "sword", gen_singular, gen_plural)
        @damage_enemy = damage_enemy
        @parent_alias = true
        @parent_singular = "sword"
        @parent_plural = "swords"
        @uses = total_uses
        @total_uses = total_uses
        @turns_into = nil
        @can_hit_things = true
        @can_cut_things = true
      end

      def use(game_status, target)
        player = game_status.player
        curr_room = game_status.curr_room
        sword_used = false
        if player.carrying != nil
          Zorkda::GameOutput.add_line("Your hands are full with something else. Drop that before using your sword.")
        elsif target.distance > self.range
          Zorkda::GameOutput.add_line("That target is too far away to hit with your sword.")
        elsif target.submerged && player.weight < 2
          Zorkda::GameOutput.add_line("That target is underwater, and you can't use your sword while floating around.")
        elsif target.is_a?(Zorkda::Actors::Character)
          Zorkda::GameOutput.add_line("Uh, no. That would be murder.")
        elsif target.effective_items == nil || (!target.effective_items.include?(self.type) && !target.stunned_by.include?(self.type))
          if target.is_a?(Zorkda::Actors::Enemy)
            Zorkda::GameOutput.add_line("You hack away with the #{self.name}, but the enemy is unaffected by the attack.")
          else
            Zorkda::GameOutput.add_line("You hack away with the #{self.name}, but nothing happens to the #{target.name}.")
          end
          sword_used = true
        else
          if target.is_a?(Zorkda::Actors::Enemy)
            target.get_hit(game_status, self.type, self.damage_enemy, "You swing your #{self.name} and injure the enemy.")
          elsif target.breakable
            target.break(curr_room, player)
          elsif target.cuttable
            target.cut(game_status)
          end
          sword_used = true
        end
        if sword_used
          self.uses -= 1
          if self.uses <= 0
            self.uses = 1.0/0.0
            Zorkda::GameOutput.add_line("Your #{self.name} broke!")
            self.name = "Broken " + self.name
            self.damage_enemy /= 4
            self.gen_plural = self.gen_plural
            self.gen_singular = self.gen_singular
          end
        end
      end
    end

    class KokiriSword < Sword

      def initialize
        super("Kokiri Sword", 1, "Kokiri Sword", "Kokiri Swords", 1.0/0.0)
        @available_as_adult = false
        @acquired_description = "This is a hidden treasure of the Kokiri, but you can borrow it for a while. You can use it with the commands &quot;hit&quot;, &quot;break&quot;, or &quot;cut&quot;."
      end
    end

    class MasterSword < Sword

      def initialize
        super("Master Sword", 2, "Master Sword", "Master Swords", 1.0/0.0)
        @available_as_child = false
        @description = "An elegant sword with a blue handle and gold inlay sits upright in a pedastal."
        @acquired_description = "This legendary sword is known as The Blade of Evil's Bane."
        @can_roll_into = false
      end
    end

    class GiantsKnife < Sword

      def initialize
        super("Giant's Knife", 4, "Giants Knife", "Giants Knives", 8)
        @available_as_child = false
        @acquired_description = "This sword is so big, you have to use both hands to hold it and can't use your shield while it is equipped."
      end
    end

    class BiggoronsSword < Sword

      def initialize
        super("Biggoron's Sword", 4, "Biggorons Sword", "Biggorons Swords", 1.0/0.0)
        @available_as_child = false
        @acquired_description = "This blade was forged by a master smith and won't break!"
      end
    end

	end
end