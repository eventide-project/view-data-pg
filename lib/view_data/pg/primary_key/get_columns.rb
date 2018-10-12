module ViewData
  module PG
    module PrimaryKey
      class GetColumns
        include Configure
        include Dependency

        configure :get_primary_key_columns

        dependency :session, Session
        dependency :telemetry, ::Telemetry

        def self.build(session: nil)
          instance = new
          Session.configure(instance, session: session)
          ::Telemetry.configure(instance)
          instance
        end

        def self.call(table)
          instance = build()
          instance.(table)
        end

        def call(table)
          cache[table]
        end

        def query(table)
          result = session.execute(<<~SQL, [table])
            SELECT
              TEXT(attr.attname) AS column_name
            FROM pg_index AS index
            JOIN pg_attribute AS attr
              ON attr.attrelid = index.indrelid
              AND attr.attnum = ANY(index.indkey)
            WHERE index.indrelid = $1::regclass
            AND index.indisprimary
          SQL

          columns = result.to_a.map do |hash|
            hash['column_name']
          end

          telemetry.record(:columns_queried, Telemetry::Data.new(table, columns))

          columns
        end

        def cache
          @cache ||= Hash.new do |hash, table|
            hash[table] = query(table)
          end
        end

        def self.register_telemetry_sink(instance)
          sink = Telemetry::Sink.new
          instance.telemetry.register(sink)
          sink
        end

        module Telemetry
          class Sink
            include ::Telemetry::Sink

            record :columns_queried
          end

          Data = Struct.new(:table, :columns)
        end
      end
    end
  end
end
