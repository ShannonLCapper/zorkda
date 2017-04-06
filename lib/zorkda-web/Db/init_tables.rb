# require "json"
# require "aws-sdk-core"

# creds = {
#   "AccessKeyId" => ENV["ZORKDA_DYNAMO_KEY"],
#   "SecretAccessKey" => ENV["ZORKDA_DYNAMO_SECRET"]
# }

# Aws.use_bundled_cert!
# Aws.config.update({
#   region: "us-west-2",
#   credentials: Aws::Credentials.new(creds["AccessKeyId"], creds["SecretAccessKey"]),
#   endpoint: "http://dynamodb.us-west-2.amazonaws.com"
#   # endpoint: "http://localhost:8000" # remove this line to access the cloud
# })
# dynamodb = Aws::DynamoDB::Client.new

### Clear tables
# dynamodb.delete_table({table_name: "Users"})
# dynamodb.delete_table({table_name: "Uuids"})
# dynamodb.delete_table({table_name: "Game_Sessions"})
# dynamodb.delete_table({table_name: "Games"})
# dynamodb.delete_table({table_name: "Game_Summaries"})
# dynamodb.delete_table({table_name: "Game_Files"})


# # USERS TABLE
# # Primary key: username (lowercased)
# # Field: password
# # Field: uuid
# # Field: salt
# # Field: display_name (case sensitive)
# users_params = {
#   table_name: "Users",
#   key_schema: [
#     {
#       attribute_name: "username",
#       key_type: "HASH" # Partition key
#     }
#   ],
#   attribute_definitions: [
#     {
#       attribute_name: "username",
#       attribute_type: "S"
#     }
#   ],
#   provisioned_throughput: {
#     read_capacity_units: 10,
#     write_capacity_units: 10
#   }
# }

# # UUIDS TABLE
# # Primary key: uuid
# # No other fields
# uuids_params = {
#   table_name: "Uuids",
#   key_schema: [
#     {
#       attribute_name: "uuid",
#       key_type: "HASH" # Partition key
#     }
#   ],
#   attribute_definitions: [
#     {
#       attribute_name: "uuid",
#       attribute_type: "S"
#     }
#   ],
#   provisioned_throughput: {
#     read_capacity_units: 10,
#     write_capacity_units: 10
#   }
# }

# # GAME_SESSIONS TABLE
# # Partition key: game_session_id
# # Field: game_file
# # Field: expire_at (epoch time)
# game_sessions_params = {
#   table_name: "Game_Sessions",
#   key_schema: [
#     {
#       attribute_name: "game_session_id",
#       key_type: "HASH"
#     }
#   ],
#   attribute_definitions: [
#     {
#       attribute_name: "game_session_id",
#       attribute_type: "S"
#     }
#   ],
#   provisioned_throughput: {
#     read_capacity_units: 10,
#     write_capacity_units: 10
#   }
# }

# # GAME_SUMMARIES TABLE
# # Partition key: uuid
# # Sort key: game_id
# # Field: game_summary
# game_summaries_params = {
#   table_name: "Game_Summaries",
#   key_schema: [
#     {
#       attribute_name: "uuid",
#       key_type: "HASH" # Partition key
#     },
#     {
#       attribute_name: "game_id",
#       key_type: "RANGE" # Sort key
#     }
#   ],
#   attribute_definitions: [
#     {
#       attribute_name: "uuid",
#       attribute_type: "S"
#     },
#     {
#       attribute_name: "game_id",
#       attribute_type: "S"
#     }
#   ],
#   provisioned_throughput: {
#     read_capacity_units: 10,
#     write_capacity_units: 10
#   }
# }

# # GAME_FILES TABLE
# # Primary key: game_id
# # Field: game_file
# game_files_params = {
#   table_name: "Game_Files",
#   key_schema: [
#     {
#       attribute_name: "uuid",
#       key_type: "HASH" # Partition key
#     },
#     {
#       attribute_name: "game_id",
#       key_type: "RANGE" # Sort key
#     }
#   ],
#   attribute_definitions: [
#     {
#       attribute_name: "uuid",
#       attribute_type: "S"
#     },
#     {
#       attribute_name: "game_id",
#       attribute_type: "S"
#     }
#   ],
#   provisioned_throughput: {
#     read_capacity_units: 10,
#     write_capacity_units: 10
#   }
# }

# [users_params, uuids_params, game_sessions_params, game_files_params, game_summaries_params].each do |params|

#   begin
#     result = dynamodb.create_table(params)
#     puts "Created table #{params[:table_name]}. Status: " +
#           result.table_description.table_status
#   rescue Aws::DynamoDB::Errors::ServiceError => error
#     puts "Unable to create #{params[:table_name]} table:"
#     puts "#{error.message}"
#   end

# end

# Make entries in Game_Sessions table auto-delete after expiration time
# begin
#   result = dynamodb.update_time_to_live({
#     table_name: "Game_Sessions",
#     time_to_live_specification: {
#       attribute_name: "expire_at",
#       enabled: true
#     }
#   })
#   print "Updated time-to-live on Game_Sessions Table. "
#   puts "Enabled: #{result.time_to_live_specification.enabled}"
       
# rescue Aws::DynamoDB::Errors::ServiceError => error
#   puts "Unable to set time-to-live on Game_Sessions Table:"
#   puts "#{error.message}"
# end