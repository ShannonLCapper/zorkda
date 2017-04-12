module Zorkda
  module Rooms

    class Crawlway < Path

      def initialize(direction)
        super(direction, "there is a small crawl space")
        @plural_description = "there are small crawl spaces"
      end
    end

  end
end