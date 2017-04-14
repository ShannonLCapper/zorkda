module Zorkda

  class GameOutput
    @@text_suppression_levels = 0
    @@text_lines = []
    @@location = {
      area: nil,
      room: nil
    }
    @@navi = false

    def self.get
      return {
        outputLines: @@text_lines,
        location: @@location,
        navi: @@navi
      }
    end

    def self.reset
      @@text_suppression_levels = 0
      @@text_lines = []
      @@location = {
        area: nil,
        room: nil
      }
      @@navi = false
    end

    def self.add_line(new_line)
      @@text_lines << new_line unless self.additions_suppressed?
    end

    def self.add_lines(new_lines)
      if new_lines.kind_of?(Array)
        @@text_lines.concat(new_lines) unless self.additions_suppressed?
      else
        self.add_line(new_lines)
      end
    end

    def self.append_text(text)
      return if self.additions_suppressed?

      if text.kind_of?(Array) && !text.empty?
        line_to_append = text[0]
      else
        line_to_append = text
      end
      if @@text_lines.empty?
        @@text_lines << line_to_append
      else
        @@text_lines[-1] += line_to_append
      end
      if text.kind_of?(Array) && !text.empty?
        self.add_lines(text[1..-1])
      end
    end

    def self.additions_suppressed?
      return true if @@text_suppression_levels > 0
      return false
    end

    def self.suppress_text_additions
      @@text_suppression_levels += 1
    end

    def self.unsuppress_text_additions
      @@text_suppression_levels -= 1
      @@text_suppression_levels = 0 if @@text_suppression_levels < 0
    end

    def self.new_paragraph
      @@text_lines << " "
    end

    def self.set_navi(boolean)
      @@navi = boolean
    end

    def self.set_location(location_hash)
      @@location = location_hash
    end

  end

end