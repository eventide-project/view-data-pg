module View
  module Postgres
    module Handlers
      class Commands
        include Messaging::Handle

        dependency :session, MessageStore::Postgres::Session
        dependency :get_primary_key_columns, PrimaryKey::GetColumns

        def configure
          Session.configure(self)
          PrimaryKey::GetColumns.configure(self, session: session)
        end

        handle Messages::Commands::Insert do |insert|
          pkey_columns = get_primary_key_columns.(insert.table)
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

        handle Messages::Commands::Update do |update|
          pkey_columns = get_primary_key_columns.(update.table)
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

        handle Messages::Commands::Delete do |delete|
          pkey_columns = get_primary_key_columns.(delete.table)
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
      end
    end
  end
end

