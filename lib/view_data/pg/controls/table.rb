module ViewData
  module PG
    module Controls
      module Table
        def self.create(drop: nil)
          session = Session.build

          if drop
            session.execute("DROP TABLE IF EXISTS test_table")
          end

          session.execute(<<~SQL)
            CREATE TABLE #{name} (
              id uuid PRIMARY KEY,
              some_column text
            )
          SQL

          session.close
        end

        def self.name
          'test_table'
        end
      end
    end
  end
end
