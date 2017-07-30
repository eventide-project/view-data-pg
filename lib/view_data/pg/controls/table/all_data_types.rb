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
                some_smallint smallint,
                some_integer integer,
                some_bigint bigint,
                some_decimal_3_1 decimal(4, 1),
                some_numeric_3_1 numeric(4, 1),
                some_real real,
                some_double_precision double precision,
                some_smallserial smallserial,
                some_serial serial,
                some_bigserial bigserial,

                -- Money
                some_money money
              )
            SQL

            session.close
          end
        end
      end
    end
  end
end
