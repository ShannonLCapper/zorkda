module Zorkda
	module Actors

		class Hookshot < InventoryWeapon

			def initialize
				super("Hookshot", "Hookshot", "Hookshots", 2, 5)
				@type = "hookshot"
				@acquired_description = "This is a spring-loaded chain that you can cast out to hook things. You can use it to drag distant items toward you, or you can use it to pull yourself toward something. Use it with the commands &quot;hit&quot;, &quot;break&quot;, and &quot;shoot&quot;."
				@parent_alias = true
				@parent_singular = "hookshot"
				@parent_plural = "hookshots"
				@can_shoot = true
				@available_as_child = false
			end
      
		end

    class Longshot < Hookshot
      
      def initialize
        super()
        @name = "Longshot"
        @acquired_description = "This is an ungraded Hookshot. It extends twice as far!"
        @range = 10
        @replace_previous = true
      end

    end

	end
end