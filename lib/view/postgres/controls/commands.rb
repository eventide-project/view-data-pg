module View
  module Postgres
    module Controls
      module Commands
        module Insert
          def self.example(primary_key: nil, table: nil, data: nil)
            primary_key ||= ID.example
            table ||= Table.name
            data ||= self.data

            insert = View::Postgres::Messages::Commands::Insert.build
            insert.table = table
            insert.primary_key = primary_key
            insert.data = data
            insert
          end

          def self.data
            { :number => 0 }
          end
        end

        module Update
          def self.example(number=nil, primary_key: nil, table: nil, data: nil)
            primary_key ||= ID.example
            table ||= Table.name
            data ||= self.data(number)

            update = View::Postgres::Messages::Commands::Update.build
            update.table = Table.name
            update.primary_key = primary_key
            update.data = data
            update
          end

          def self.data(number=nil)
            number ||= 1

            { :number => number }
          end
        end

        module Delete
          def self.example(primary_key: nil, table: nil)
            primary_key ||= ID.example
            table ||= Table.name

            delete = View::Postgres::Messages::Commands::Delete.build
            delete.table = table
            delete.primary_key = primary_key
            delete
          end
        end
      end
    end
  end
end
