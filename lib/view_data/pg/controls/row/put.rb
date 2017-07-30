module ViewData
  module PG
    module Controls
      module Row
        module Put
          def self.call
            identifier = ID::Random.example
            column_value = Controls::Data.column_value
            table_name = Table.name

            session = Session.build

            session.execute(<<~SQL, [identifier, column_value])
            INSERT INTO #{table_name} (id, some_column) VALUES ($1, $2)
            SQL

            session.close

            identifier
          end
        end
      end
    end
  end
end
