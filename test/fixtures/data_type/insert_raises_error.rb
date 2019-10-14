module Fixtures
  module DataType
    class InsertRaisesError
      include TestBench::Fixture
      include Initializer

      initializer :error_class, :column, :value

      def self.call(error_class, column:, value:)
        instance = new(error_class, column, value)
        instance.()
      end

      def call
        id = Controls::ID::Random.example

        session = ViewData::PG::Session.build

        context "Insert #{value.inspect}" do
          error_class = self.error_class

          test "Insert statement raises #{error_class}" do
            assert_raises error_class do
              session.execute(
                %{INSERT INTO all_data_types (id, #{column}) VALUES ($1, $2)},
                [id, value]
              )
            end
          end
        end

      ensure
        session.close if session.connected?
      end
    end
  end
end

