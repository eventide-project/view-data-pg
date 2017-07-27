module View
  module Postgres
    module Controls
      module CompositePrimaryKey
        module Table
          def self.name
            'composite_primary_key_table'
          end

          module Reset
            def self.call
              session = Session.get

              session.execute(<<~SQL)
              DROP TABLE IF EXISTS #{Table.name}
              SQL

              column_names = CompositePrimaryKey.column_names

              session.execute(<<~SQL)
              CREATE TABLE #{Table.name} (
                #{column_names[0]} UUID NOT NULL,
                #{column_names[1]} UUID NOT NULL,
                number INTEGER NOT NULL,
                other_column TEXT,
                PRIMARY KEY(#{column_names[0]}, #{column_names[1]})
              )
              SQL
            end
          end
        end
      end
    end
  end
end
