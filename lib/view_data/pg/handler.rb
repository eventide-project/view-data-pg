module ViewData
  module PG
    class Handler
      include Messaging::Handle
      include Log::Dependency

      include ViewData::Commands

      dependency :session, Session
      dependency :get_primary_key_columns, PrimaryKey::GetColumns

      def configure
        Session.configure(self)
        PrimaryKey::GetColumns.configure(self, session: session)
      end

      handle Create do |create|
        table_name = create.name

        logger.trace { "Inserting row (Table: #{table_name}, Identifier: #{create.identifier.inspect})" }

        pkey_columns = get_primary_key_columns.(table_name)
        pkey_values = Array(create.identifier)

        data_columns = create.data.keys
        data_values = create.data.values

        columns = pkey_columns + data_columns

        quoted_columns = columns.map do |column|
          quote_columns(column)
        end

        values = pkey_values + data_values

        values_clause = values.count.times.map do |i|
          "$#{i + 1}"
        end

        statement = <<~SQL.chomp
          INSERT INTO #{quote_table_name(table_name)} (#{quoted_columns * ', '})
          VALUES (#{values_clause * ', '})
        SQL

        begin
          logger.trace { "Inserting row (Table: #{table_name}, Identifier: #{create.identifier.inspect})" }
          logger.trace(tag: :data) { "SQL: #{statement}" }
          logger.trace(tag: :data) { values.pretty_inspect }

          session.execute(statement, values)

          logger.info { "Inserted row (Table: #{table_name}, Identifier: #{create.identifier.inspect})" }
          logger.info(tag: :data) { "SQL: #{statement}" }
          logger.info(tag: :data) { values.pretty_inspect }

        rescue ::PG::UniqueViolation
        end
      end

      handle Update do |update|
        table_name = update.name

        logger.trace { "Updating row (Table: #{table_name}, Identifier: #{update.identifier.inspect})" }

        pkey_columns = get_primary_key_columns.(table_name)
        pkey_values = Array(update.identifier)

        data_columns = update.data.keys
        data_values = update.data.values

        set_clause = data_columns.map.with_index do |column, index|
          quoted_column = quote_columns(column)

          reference = index + 1

          "#{quoted_column} = $#{reference}"
        end

        pkey_clause = pkey_columns.map.with_index do |column, index|
          quoted_column = quote_columns(column)

          reference = index + data_columns.count + 1

          "#{quoted_column} = $#{reference}"
        end

        values = data_values + pkey_values

        statement = <<~SQL.chomp
          UPDATE #{quote_table_name(table_name)}
          SET #{set_clause * ', '}
          WHERE #{pkey_clause * ' AND '}
        SQL

        logger.trace { "Updating row (Table: #{table_name}, Identifier: #{update.identifier.inspect})" }
        logger.trace(tag: :data) { "SQL: #{statement}" }
        logger.trace(tag: :data) { values.pretty_inspect }

        session.execute(statement, values)

        logger.info { "Updated row (Table: #{table_name}, Identifier: #{update.identifier.inspect})" }
        logger.info(tag: :data) { "SQL: #{statement}" }
        logger.info(tag: :data) { values.pretty_inspect }
      end

      handle Delete do |delete|
        table_name = delete.name

        logger.trace { "Deleting row (Table: #{table_name}, Identifier: #{delete.identifier.inspect})" }

        pkey_columns = get_primary_key_columns.(table_name)
        pkey_values = Array(delete.identifier)

        pkey_clause = pkey_columns.map.with_index do |column, index|
          quoted_column = quote_columns(column)

          reference = index + 1

          "#{quoted_column} = $#{reference}"
        end

        statement = <<~SQL.chomp
          DELETE FROM #{quote_table_name(table_name)}
          WHERE #{pkey_clause * ' AND '}
        SQL

        logger.trace { "Deleting row (Table: #{table_name}, Identifier: #{delete.identifier.inspect})" }
        logger.trace(tag: :data) { "SQL: #{statement}" }
        logger.trace(tag: :data) { pkey_values.pretty_inspect }

        session.execute(statement, pkey_values)

        logger.info { "Deleted row (Table: #{table_name}, Identifier: #{delete.identifier.inspect})" }
        logger.info(tag: :data) { "SQL: #{statement}" }
        logger.info(tag: :data) { pkey_values.pretty_inspect }
      end

      def quote_columns(column)
        session.connect.quote_ident(column.to_s)
      end

      def quote_table_name(name)
        session.connect.quote_ident(name.to_s.split('.'))
      end
    end
  end
end
