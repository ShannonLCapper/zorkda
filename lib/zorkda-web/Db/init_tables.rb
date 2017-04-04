# require "json"
# require "aws-sdk-core"

# creds = JSON.load(File.read("secrets.json"))

# Aws.use_bundled_cert!
# Aws.config.update({
#   region: "us-west-2",
#   credentials: Aws::Credentials.new(creds["AccessKeyId"], creds["SecretAccessKey"])
#   # endpoint: "http://localhost:8000" # remove this line to access the cloud
# })
# dynamodb = Aws::DynamoDB::Client.new

# #### Clear tables
# # dynamodb.delete_table({table_name: "Users"})
# # dynamodb.delete_table({table_name: "Uuids"})
# # dynamodb.delete_table({table_name: "Games"})

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

# # GAMES TABLE
# # Partition key: uuid
# # Sort key: game_id
# # Field: game_file
# # Field: game_summary
# games_params = {
#   table_name: "Games",
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

# [users_params, uuids_params, games_params].each do |params|
#   begin
#     result = dynamodb.create_table(params)
#     puts "Created table #{params[:table_name]}. Status: " +
#           result.table_description.table_status

#   rescue Aws::DynamoDB::Errors::ServiceError => error
#     puts "Unable to create #{params[:table_name]} table:"
#     puts "#{error.message}"
#   end

# end