module View
  module Postgres
    module Controls
      module Table
        def self.name
          'some_table'
        end

        module Reset
          def self.call
            session = Session.get

            session.execute(<<~SQL)
              DROP TABLE IF EXISTS #{Table.name}
            SQL

            session.execute(<<~SQL)
              CREATE TABLE #{Table.name} (
                id UUID PRIMARY KEY,
                number INTEGER NOT NULL,
                other_column TEXT
              )
            SQL
          end
        end
      end
    end
  end
end
