module Zorkda

  module Db
    require "aws-sdk-core"
    require "json"
    require "oj"
    require "dotenv/load"
    # require "logger"

    creds = {
      "AccessKeyId" => ENV["ZORKDA_DYNAMO_KEY"],
      "SecretAccessKey" => ENV["ZORKDA_DYNAMO_SECRET"]
    }

    Aws.use_bundled_cert!
    Aws.config.update({
      region: "us-west-2",
      credentials: Aws::Credentials.new(creds["AccessKeyId"], creds["SecretAccessKey"]),
      # logger: Logger.new($stdout),
      # log_level: :debug,
      # endpoint: "http://dynamodb.us-west-2.amazonaws.com"
      endpoint: "http://localhost:8000" # remove this line to access the cloud
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
        table_name: "Game_Summaries",
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

    def self.put_game_summary(game_info) #uuid, game_id, game_summary
      dynamodb = self.connect
      params = {
        table_name: "Game_Summaries",
        item: game_info
      }
      begin
        result = dynamodb.put_item(params)
        return "success"
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "write error"
      end
    end

    def self.get_saved_game(uuid, game_id, symbolize_and_decode = true)
      dynamodb = self.connect
      begin
        result = dynamodb.get_item({
          table_name: "Game_Files",
          key: { uuid: uuid, game_id: game_id }
        })
        return result.item unless symbolize_and_decode
        game_info = self.symbolize(result.item)
        game_info[:game_file] = Zorkda::ObjectEncoder.bytes_to_obj(game_info[:game_file])
        return game_info
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "read error"
      end
    end

    def self.add_saved_game(game_info) #uuid, game_id, game_file
      dynamodb = self.connect
      params = {
        table_name: "Game_Files",
        item: game_info
      }
      begin
        result = dynamodb.put_item(params)
        return "success"
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "write error"
      end
    end

    def self.get_game_session(game_session_id, symbolize_and_decode = true)
      dynamodb = self.connect
      begin
        # start = Time.now
        # puts "getting game session"
        result = dynamodb.get_item({
          table_name: "Game_Sessions",
          key: { game_session_id: game_session_id }
        })
        # puts "game session received, time taken: #{Time.now - start}"
        return result.item unless symbolize_and_decode
        game_info = self.symbolize(result.item)
        game_info[:game_file] = Zorkda::ObjectEncoder.bytes_to_obj(game_info[:game_file])
        return game_info
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "read error"
      end
    end

    def self.add_game_session(game_info) #game_session_id, game_file, expire_at
      dynamodb = self.connect
      params = {
        table_name: "Game_Sessions",
        item: game_info
      }
      begin
        # start = Time.now
        # puts "saving game session"
        result = dynamodb.put_item(params)
        # puts "game session saved, time taken: #{Time.now - start}"
        return "success"
      rescue Aws::DynamoDB::Errors::ServiceError => error
        return "write error"
      end
    end

  end
end