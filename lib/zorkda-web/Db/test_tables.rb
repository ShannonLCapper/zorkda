require "json"
require "aws-sdk-core"
require "bcrypt"

# creds = JSON.load(File.read("secrets.json"))

# Aws.config.update({
#   region: "us-west-2",
#   # credentials: Aws::Credentials.new(creds["AccessKeyId"], creds["SecretAccessKey"])
#   endpoint: "http://localhost:8000" # remove this line to access the cloud
# })
# dynamodb = Aws::DynamoDB::Client.new

# def salt_and_encrypt_password(password)
#   salt = SecureRandom.hex
#   return encrypt_password(password, salt), salt
# end

# def encrypt_password(password, salt)
#   password_salt = password + salt
#   return BCrypt::Password.create(password_salt)
# end

# def convert_encrypted_password(encrypted_password)
#   return BCrypt::Password.new(encrypted_password)
# end

### Add users to Users table and their UUID to the Uuids table
# password, salt = salt_and_encrypt_password("aaa")

# entry_1 = {
#   username: "scapper",
#   display_name: "Scapper",
#   password: password,
#   uuid: SecureRandom.uuid,
#   salt: salt
# }

# password, salt = salt_and_encrypt_password("bbb")
# entry_2 = {
#   username: "mporetti",
#   display_name: "mPoretti",
#   password: password,
#   uuid: SecureRandom.uuid,
#   salt: salt
# }

# user_params = {
#   table_name: "Users",
#   item: nil,
#   condition_expression: "attribute_not_exists(username)"
# }

# uuid_params = {
#   table_name: "Uuids",
#   item: { uuid: nil },
#   condition_expression: "attribute_not_exists(#id)",
#   expression_attribute_names: { "#id": "uuid"}
# }


# [entry_1, entry_2].each do |entry|
#   user_params[:item] = entry
#   uuid_params[:item][:uuid] = entry[:uuid]
#   begin
#     result = dynamodb.put_item(user_params)
#     puts "Added user #{entry[:username]} to Users table"
#   rescue Aws::DynamoDB::Errors::ServiceError => error
#     puts "Unable to add user #{entry[:username]}:"
#     puts "#{error.message}"
#   end
#   begin
#     result = dynamodb.put_item(uuid_params)
#     puts "Added uuid #{uuid_params[:item][:uuid]} to Uuid table"
#   rescue Aws::DynamoDB::Errors::ServiceError => error
#     puts "Unable to add uuid #{uuid_params[:item][:uuid]}:"
#     puts "#{error.message}"
#   end
# end

#### Retrieve a user test
# begin
#   result = dynamodb.get_item({
#     table_name: "Users",
#     key: { username: "scapper" }
#   })
#   puts "stored password: " + result.item["password"]
#   puts "salt: " + result.item["salt"]
#   puts "passwords match: #{convert_encrypted_password(result.item['password']) == 'aaa' + result.item['salt']}"
# rescue Aws::DynamoDB::Errors::ServiceError => error
#   puts "Unable to read user: "
#   puts "#{error.message}"
# end

# encrypt_pass_1, salt = salt_and_encrypt_password("aaa")
# encrypt_pass_2 = encrypt_password("aaa", salt)

# puts "encrypt_pass_1 == encrypt_pass_2: #{encrypt_pass_1 == 'aaa' + salt}"

#### Delete a uuid
# uuid = "7fdd078e-1d9d-40dc-878a-3823fdf74221"
# begin
#   result = dynamodb.delete_item({
#     table_name: "Uuids",
#     key: {uuid: uuid}
#     })
#   puts "Deleted uuid #{uuid}"
# rescue Aws::DynamoDB::Errors::ServiceError => error
#   puts "Unable to delete uuid #{uuid}:"
#   puts "#{error.message}"
# end


#### Add games conditionally to the Games table
# game_1 = {
#   uuid: "aaa",
#   game_id: "aaa1",
#   game_file: {moves: 10},
#   game_summary: {}
# }

# game_2 = {
#   uuid: "aaa",
#   game_id: "aaa2",
#   game_file: {moves: 20},
#   game_summary: {}
# }

# [game_1, game_2].each do |game|

#   params = {
#     table_name: "Games",
#     item: game,
#     condition_expression: "attribute_not_exists(#id)",
#     expression_attribute_names: { "#id": "uuid"},
#   }
#   begin
#     result = dynamodb.put_item(params)
#     puts "Added #{game[:uuid]} #{game[:game_id]} to Games Table"
#   rescue Aws::DynamoDB::Errors::ServiceError => error
#     puts "Unable to game #{game[:uuid]} #{game[:game_id]}:"
#     puts "#{error.message}"
#   end

# end

# #### Retrieving game from Games table
# begin
#   result = dynamodb.get_item({
#     table_name: "Games",
#     key: { uuid: "aaa", game_id: "aaa1" }
#   })
#   puts "Number of moves: #{result.item["game_file"]["moves"]}"
# rescue Aws::DynamoDB::Errors::ServiceError => error
#   puts "Unable to read game: "
#   puts "#{error.message}"
# end

# #### Overwriting a game
# game = {
#   uuid: "aaa",
#   game_id: "aaa1",
#   game_file: {moves: 100},
#   game_summary: {}
# }
# params = {
#   table_name: "Games",
#   item: game
# }
# begin
#   result = dynamodb.put_item(params)
#   puts "Added #{game[:uuid]} #{game[:game_id]} to Games Table"
# rescue Aws::DynamoDB::Errors::ServiceError => error
#   puts "Unable to add game #{game[:uuid]} #{game[:game_id]}:"
#   puts "#{error.message}"
# end

# begin
#   result = dynamodb.get_item({
#     table_name: "Games",
#     key: { uuid: "bbb", game_id: "bbb1" }
#   })
#   puts "Result is #{result.item}"
#   # puts "Number of moves: #{result.item["game_file"]["moves"]}"
# rescue Aws::DynamoDB::Errors::ServiceError => error
#   puts "Unable to read game: "
#   puts "#{error.message}"
# end