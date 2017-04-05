module Zorkda

  module Db
    require "aws-sdk-core"
    require "json"
    require "oj"

    creds = {
      "AccessKeyId" => ENV["ZORKDA_DYNAMO_KEY"],
      "SecretAccessKey" => ENV["ZORKDA_DYNAMO_SECRET"]
    }

    Aws.use_bundled_cert!
    Aws.config.update({
      region: "us-west-2",
      credentials: Aws::Credentials.new(creds["AccessKeyId"], creds["SecretAccessKey"])
      # endpoint: "http://localhost:8000" # remove this line to access the cloud
    })

    Oj.default_options = { 
      bigdecimal_as_decimal: true,
      symbol_keys: true
    }

    def self.connect
      return Aws::DynamoDB::Client.new
    end

    def self.symbolize(hash)
      return nil if hash.nil?
      return Oj.load(Oj.dump(hash))
    end

    def self.get_user(username)
      dynamodb = self.connect
      begin
        result = dynamodb.get_item({
          table_name: "Users",
          key: { username: username }
        })
        return self.symbolize(result.item)
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "read error"
      end
    end

    def self.add_user(user_info)
      dynamodb = self.connect
      params = {
        table_name: "Users",
        item: user_info,
        condition_expression: "attribute_not_exists(username)"
      }
      begin
        result = dynamodb.put_item(params)
        return "success"
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "taken" if error.message == "The conditional request failed"
        return "write error"
      end
    end

    def self.get_uuid(uuid)
      dynamodb = self.connect
      begin
        result = dynamodb.get_item({
          table_name: "Uuids",
          key: { uuid: uuid }
        })
        return self.symbolize(result.item)
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "read error"
      end
    end

    def self.add_uuid(uuid)
      dynamodb = self.connect
      params = {
        table_name: "Uuids",
        item: { uuid: uuid },
        condition_expression: "attribute_not_exists(#id)",
        expression_attribute_names: { "#id": "uuid"}
      }
      begin
        result = dynamodb.put_item(params)
        return "success"
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "taken" if error.message == "The conditional request failed"
        return "write error"
      end
    end

    def self.delete_uuid(uuid)
      begin
        result = dynamodb.delete_item({
          table_name: "Uuids",
          key: {uuid: uuid}
          })
        return "success"
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "delete error"
      end
    end

    def self.get_game_summaries(uuid)
      dynamodb = self.connect
      params = {
        table_name: "Games",
        key_condition_expression: "#id = :uuid",
        expression_attribute_names: {"#id": "uuid"},
        expression_attribute_values: { ":uuid": uuid },
        scan_index_forward: true
      }
      game_summaries = []
      loop do
        result = dynamodb.query(params)
        result.items.each do |game_entry| 
          game_summary = self.symbolize(game_entry["game_summary"])
          game_summary[:saveTimestamp] = game_summary[:saveTimestamp].to_i
          game_summaries << game_summary
        end
        break if result.last_evaluated_key.nil?
        params[:exclusive_start_key] = result.last_evaluated_key
      end
      return game_summaries

    end

    def self.get_game(uuid, game_id)
      dynamodb = self.connect
      begin
        result = dynamodb.get_item({
          table_name: "Games",
          key: { uuid: uuid, game_id: game_id }
        })
        puts "fetched game data raw: #{result.item}"
        symbolized = self.symbolize(result.item)
        puts "converted game data: #{symbolized}"
        return symbolized
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "read error"
      end
    end

    def self.add_game(game_info) #uuid, game_id, game_file, game_summary)
      dynamodb = self.connect
      params = {
        table_name: "Games",
        item: game_info,
        # {
        #   uuid: uuid,
        #   game_id: game_id,
        #   game_file: game_file,
        #   game_summary: game_summary
        # },
        condition_expression: "attribute_not_exists(#id)",
        expression_attribute_names: { "#id": "uuid"}
      }
      begin
        result = dynamodb.put_item(params)
        return "success"
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "taken" if error.message == "The conditional request failed"
        return "write error"
      end
    end

    def self.update_game(game_info)
      dynamodb = self.connect
      params = {
        table_name: "Games",
        item: game_info
      }
      begin
        result = dynamodb.put_item(params)
        return "success"
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "write error"
      end
    end

  end

end