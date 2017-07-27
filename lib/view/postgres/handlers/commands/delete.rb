module View
  module Postgres
    module Handlers
      module Commands
        class Delete
          include Messaging::Handle

          dependency :session, MessageStore::Postgres::Session

          def configure
            Session.configure(self)
          end

          handle Messages::Commands::Delete do |delete|
            pkey_columns = get_primary_key_columns(delete.table)
            pkey_values = Array(delete.primary_key)

            pkey_clause = pkey_columns.map.with_index do |column_name, index|
              reference = index + 1

              "#{column_name} = $#{reference}"
            end

            statement = <<~SQL
            DELETE FROM #{delete.table}
            WHERE #{pkey_clause * ' AND '}
            SQL

            session.execute(statement, pkey_values)
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

