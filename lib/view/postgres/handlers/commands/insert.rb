module View
  module Postgres
    module Handlers
      module Commands
        class Insert
          include Messaging::Handle

          dependency :session, MessageStore::Postgres::Session

          def configure
            Session.configure(self)
          end

          handle Messages::Commands::Insert do |insert|
            pkey_columns = get_primary_key_columns(insert.table)
            pkey_values = Array(insert.primary_key)

            data_columns = insert.data.keys
            data_values = insert.data.values

            columns = pkey_columns + data_columns

            values = pkey_values + data_values

            values_clause = values.count.times.map do |i|
              "$#{i + 1}"
            end

            statement = <<~SQL
            INSERT INTO #{insert.table} (#{columns * ', '})
            VALUES (#{values_clause * ', '})
            SQL

            begin
              session.execute(statement, values)
            rescue PG::UniqueViolation
            end
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
