module ViewData
  module PG
    module Controls
      module Row
        module Put
          def self.call
            primary_key = PrimaryKey::UUID.example
            column_value = Controls::Data.column_value
            table_name = Table.name

            session = Session.build

            session.execute(<<~SQL, [primary_key, column_value])
              INSERT INTO #{table_name} (id, some_column) VALUES ($1, $2)
            SQL

            session.close

            primary_key
          end

          module CompositePrimaryKey
            def self.call
              id_1, id_2 = PrimaryKey::Composite.example
              column_value = Controls::Data.column_value
              table_name = Table::CompositePrimaryKey.name

              session = Session.build

              session.execute(<<~SQL, [id_1, id_2, column_value])
                INSERT INTO #{table_name} (id_1, id_2, some_column) VALUES ($1, $2, $3)
              SQL

              session.close

              return id_1, id_2
            end
          end
        end
      end
    end
  end
end
