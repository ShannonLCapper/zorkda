require "require_all"

require_all "lib"
# Dir["#{File.dirname(__FILE__)}/zorkda-web/Db/**/*.rb"].each { |file| require file }
# Dir["#{File.dirname(__FILE__)}/zorkda-web/GameFileCookie/**/*.rb"].each { |file| require file }
# Dir["#{File.dirname(__FILE__)}/zorkda-web/GameFileHandler/**/*.rb"].each { |file| require file }
# Dir["#{File.dirname(__FILE__)}/zorkda-web/User/**/*.rb"].each { |file| require file }

module Zorkda

  def Zorkda.start

  #     puts '''
  #                                            /@
  #                            __        __   /\/
  #                           /==\      /  \_/\/   
  #                         /======\    \/\__ \__
  #                       /==/\  /\==\    /\_|__ \
  #                    /==/    ||    \=\ / / / /_/
  #                  /=/    /\ || /\   \=\/ /     
  #               /===/   /   \||/   \   \===\
  #             /===/   /_________________ \===\   ================================================
  #          /====/   / |                /  \====\         THE LEGEND OF
  #        /====/   /   |  _________    /  \   \===\   ============================================ 
  #        /==/   /     | /   /  \ / / /  __________\___________   ___________ ______       ___
  #       |===| /       |/   /____/ / /   \   _____  |\   ____  \  \   / \  _/ \   _ \      \  \
  #        \==\             /\   / / /     | |   /=| | | |    \  |  | |  / /    | | \ \     / _ \
  #        \===\__    \    /  \ / / /   /  | |__/==| | | |    |  |  | | / /     | |  \ \   / / \ \
  #          \==\ \    \\\\ /____/   /_\ //  | |  /==| | | |____/  |  | |/ /      | |   | | / /___\ \
  #          \===\ \   \\\\\\\\\\\\\/   /////// /| | /===| | |  __  __/   |  _ \      | |   | | |  ___  |
  #            \==\/     \\\\\\\\/ / //////   \| | /==/| | | |  \ \     | | \ \     | |   | | | /   \ |
  #            \==\     _ \\\\/ / /////    _ | | /==/| | | |   \ \    | |  \ \    | |  / /  | |   | |
  #              \==\  / \ / / ///      /|\| |==/__| | | |    \ \_  | |   \ \_  | |_/ /   | |   | |
  #              \==\ /   / / /________/ |/__________//___\   /___\/___\  /___\/_____/   /___\ /___\
  #                \==\  /               | /==/
  #                \=\  /________________|/=/  =====================================================
  #                  \==\     _____     /==/                              OCARINA OF TIME   
  #                 / \===\   \   /   /===/  =======================================================
  #                / / /\===\  \_/  /===/
  #               / / /   \====\ /====/
  #              / / /      \===|===/
  #              |/_/         \===/
  #                             =  




  #     '''

  #     puts "Do you want to start a new game, or load a saved game?"
  #     valid_response = false
  #     until valid_response == true
  #     	valid_response = true
  #     	response = prompt
  #     	if (response.include?("start") || response.include?("new")) && !response.include?("saved")
  #     		file_name = make_username_and_password
  #     		initialize_new_game(file_name)
  #     	elsif (response.include?("load") || response.include?("saved")) && !response.include?("new")
  #     		file_name = get_username_and_password
  #     		if file_name == nil
  #     			valid_response = false
  #     			puts "Do you want to start a new game, or load a saved game?"
  #     		else
  #     	 		load_game(file_name)
  #     		end
  #     	else
  #     		valid_response = false
  #     		puts "That's not a valid response. Type \"start new game\" or \"load saved game\"."
  #     	end
  #     end

  #   else
  #     initialize_new_game("File_1")
  #   end

  end

end