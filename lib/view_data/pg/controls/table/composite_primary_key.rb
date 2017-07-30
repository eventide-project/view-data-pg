module ViewData
  module PG
    module Controls
      module Table
        module CompositePrimaryKey
          def self.create(drop: nil)
            session = Session.build

            if drop
              session.execute("DROP TABLE IF EXISTS #{name}")
            end

            session.execute(<<~SQL)
              CREATE TABLE #{name} (
                id_1 uuid NOT NULL,
                id_2 uuid NOT NULL,

                some_column text,

                PRIMARY KEY(id_1, id_2)
              )
            SQL

            session.close
          end

          def self.name
            'test_composite_primary_key'
          end
        end
      end
    end
  end
end
