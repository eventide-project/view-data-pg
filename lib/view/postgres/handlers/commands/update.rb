module View
  module Postgres
    module Handlers
      module Commands
        class Update
          include Messaging::Handle

          dependency :session, MessageStore::Postgres::Session

          def configure
            Session.configure(self)
          end

          handle Messages::Commands::Update do |update|
            pkey_columns = get_primary_key_columns(update.table)
            pkey_values = Array(update.primary_key)

            data_columns = update.data.keys
            data_values = update.data.values

            set_clause = data_columns.map.with_index do |column_name, index|
              reference = index + 1

              "#{column_name} = $#{reference}"
            end

            pkey_clause = pkey_columns.map.with_index do |column_name, index|
              reference = index + data_columns.count + 1

              "#{column_name} = $#{reference}"
            end

            values = data_values + pkey_values

            statement = <<~SQL
            UPDATE #{update.table}
            SET #{set_clause * ', '}
            WHERE #{pkey_clause * ' AND '}
            SQL

            session.execute(statement, values)
          end

          def get_primary_key_columns(table)
            result = session.execute(<<~SQL, [table])
            SELECT
              TEXT(attr.attname) AS column_name
            FROM pg_index AS index
            JOIN pg_attribute AS attr
              ON attr.attrelid = index.indrelid
              AND attr.attnum = ANY(index.indkey)
            WHERE index.indrelid = $1::regclass
            AND index.indisprimary
            SQL

            result.to_a.map do |hash|
              hash['column_name']
            end
          end
        end
      end
    end
  end
end
