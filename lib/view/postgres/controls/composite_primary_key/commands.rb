module View
  module Postgres
    module Controls
      module CompositePrimaryKey
        module Commands
          module Insert
            def self.example
              primary_key = CompositePrimaryKey.primary_key
              table = Table.name

              Controls::Commands::Insert.example(
                primary_key: primary_key,
                table: table
              )
            end
          end

          module Update
            def self.example(number=nil)
              primary_key = CompositePrimaryKey.primary_key
              table = Table.name

              Controls::Commands::Update.example(
                number,
                primary_key: primary_key,
                table: table
              )
            end
          end

          module Delete
            def self.example
              primary_key = CompositePrimaryKey.primary_key
              table = Table.name

              Controls::Commands::Delete.example(
                primary_key: primary_key,
                table: table
              )
            end
          end
        end
      end
    end
  end
end
