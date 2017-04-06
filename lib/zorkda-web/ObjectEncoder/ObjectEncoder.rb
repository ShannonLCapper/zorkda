module Zorkda
	module ObjectEncoder

    def self.encode(obj)
      return Marshal.dump(obj).bytes
    end

    def self.decode(bytes)
      return Marshal.load(bytes.pack("C*"))
    end

	end
end