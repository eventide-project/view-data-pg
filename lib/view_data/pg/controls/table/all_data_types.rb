module ViewData
  module PG
    module Controls
      module Table
        module AllDataTypes
          def self.create(drop: nil)
            session = Session.build

            if drop
              session.execute("DROP TABLE IF EXISTS all_data_types")
            end

            session.execute(<<~SQL)
              CREATE TABLE all_data_types (
                id uuid PRIMARY KEY,

                -- Numbers
                some_smallint smallint
              )
            SQL

            session.close
          end
        end
      end
    end
  end
end
