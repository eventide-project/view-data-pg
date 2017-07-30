module Fixtures
  module DataType
    class CheckValue
      include TestBench::Fixture

      initializer :column, :value

      def self.call(column:, value:)
        instance = new(column, value)
        instance.()
      end

      def call
        id = Controls::ID::Random.example

        session = ViewData::PG::Session.build

        context "Insert #{value}" do
          session.execute(
            %{INSERT INTO all_data_types (id, #{column}) VALUES ($1, $2)},
            [id, value]
          )

          comment "Inserted row (ID: #{id}, Value: #{value.inspect})"

          context "Get Row Back" do
            result = session.execute(
              "SELECT #{column} AS value FROM all_data_types WHERE id = $1 LIMIT 1",
              [id]
            )

            row = result.to_a.fetch(0)

            test "Value (#{value.inspect}) is returned" do
              comment "Value returned: #{row['value'].inspect}"

              assert(row['value'] == value)
            end
          end
        end

      ensure

        if session.connected?
          session.execute("DELETE FROM all_data_types WHERE id = $1", [id])
          session.close
        end
      end
    end
  end
end
