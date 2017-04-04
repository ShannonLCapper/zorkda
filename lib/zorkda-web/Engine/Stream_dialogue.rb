module GetKey

  # Check if Win32API is accessible or not
  @use_stty = begin
    require 'Win32API'
    false
  rescue LoadError
    # Use Unix way
    true
  end

  # Return the ASCII code last key pressed, or nil if none
  #
  # Return::
  # * _Integer_: ASCII code of the last key pressed, or nil if none
  def self.getkey
    if @use_stty
      system('stty raw -echo') # => Raw mode, no echo
      char = (STDIN.read_nonblock(1).ord rescue nil)
      system('stty -raw echo') # => Reset terminal mode
      return char
    else
      return Win32API.new('msvcrt', '_kbhit', [ ], 'I').Call.zero? ? nil : Win32API.new('msvcrt', '_getch', [ ], 'L').Call
    end
  end

end

def stream_dialogue(dialogue)
	i = 0
	until i >= dialogue.length
		k = GetKey.getkey
		if k != nil && k.chr == " "
			print dialogue[i..i + 2]
			i += 3
		elsif k != nil && k == 13 || k == 10 #user pressing enter key
			print dialogue[i..-1]
			break
		else
			print dialogue[i]
			i += 1
			sleep(0.05)
		end
	end
end