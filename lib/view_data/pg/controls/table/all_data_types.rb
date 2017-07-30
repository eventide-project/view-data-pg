module ViewData
  module PG
    module Controls
      module Table
        module AllDataTypes
          def self.create(drop: nil)
            session = Session.build

            if drop
              session.execute("DROP TABLE IF EXISTS all_data_types")
              session.execute("DROP TYPE some_enum_type")
            end

            begin
              session.execute(<<~SQL)
                CREATE TYPE some_enum_type AS ENUM (
                  '#{Enum.example}',
                  '#{Enum.alternate}'
                  )
              SQL
            rescue ::PG::DuplicateObject
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
                some_money money,

                -- Character
                some_varchar_3 character varying(3),
                some_char_3 character(3),
                some_text text,

                -- Binary
                some_bytea bytea,

                -- Date/Time
                some_timestamp_3 timestamp(3) without time zone,
                some_timestamp_3_with_tz timestamp(3) with time zone,
                some_date date,
                some_time_3 time(3) without time zone,
                some_time_3_with_tz time(3) with time zone,
                some_interval_year interval YEAR,
                some_interval_second_3 interval SECOND(3),

                -- Boolean
                some_boolean bool,

                -- Enum
                some_enum some_enum_type,

                -- UUID
                some_uuid uuid
              )
            SQL

            session.close
          end
        end
      end
    end
  end
end
