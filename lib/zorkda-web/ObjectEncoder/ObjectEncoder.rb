module Zorkda
	module ObjectEncoder

    def self.obj_to_bytes(obj)
      marshal_string = self.obj_to_str(obj)
      return self.str_to_bytes(marshal_string)
    end

    def self.bytes_to_obj(bytes)
      marshal_string = self.bytes_to_str(bytes)
      return self.str_to_obj(marshal_string)
    end

    def self.obj_to_str(obj)
      return Marshal.dump(obj)
    end

    def self.str_to_obj(marshal_string)
      return Marshal.load(marshal_string)
    end

    def self.str_to_bytes(marshal_string)
      return marshal_string.bytes
    end

    def self.bytes_to_str(bytes)
      return bytes.pack("C*")
    end

	end
end