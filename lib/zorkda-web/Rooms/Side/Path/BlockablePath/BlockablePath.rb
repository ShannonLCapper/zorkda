module Zorkda
	module Rooms

    #DONE
		class BlockablePath < Path

			attr_accessor :blocked, :blocked_desc, :unblocked_desc, :blocked_damage, :blocked_attempt_message,
			:blocked_plural_desc, :unblocked_plural_desc

			def initialize(direction, blocked_desc, unblocked_desc, blocked, blocked_attempt_message)
				@blocked_desc = blocked_desc
				@unblocked_desc = unblocked_desc
				@blocked = blocked
				if blocked
					super(direction, blocked_desc)
				else
					super(direction, unblocked_desc)
				end
				@blocked_damage = 0
				@blocked_attempt_message = blocked_attempt_message
				@blocked_plural_desc = nil
				@unblocked_plural_desc = nil
			end

			def unblock
				self.blocked = false
				self.description = self.unblocked_desc
				if self.unblocked_plural_desc.nil?
					self.plural_description = self.description
				else
					self.plural_description = self.unblocked_plural_desc
				end
			end

			def block
				self.blocked = true
				self.description = self.blocked_desc
				if self.blocked_plural_desc.nil?
					self.plural_description = self.description
				else
					self.plural_description = self.blocked_plural_desc
				end
			end

			def update_plural_desc
				if self.blocked
					self.plural_description = self.blocked_plural_desc
				else
					self.plural_description = self.unblocked_plural_desc
				end
			end
		end

	end
end