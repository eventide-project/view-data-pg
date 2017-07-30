module Fixtures
  module DataType
    class InsertRaisesError
      include TestBench::Fixture

      initializer :error_class, :column, :value

      def self.call(error_class, column:, value:)
        instance = new(error_class, column, value)
        instance.()
      end

      def call
        id = Controls::ID::Random.example

        session = ViewData::PG::Session.build

        context "Insert #{value.inspect}" do
          insert_proc = proc {
            session.execute(
              %{INSERT INTO all_data_types (id, some_smallint) VALUES ($1, $2)},
              [id, value]
            )
          }

          error_class = self.error_class

          test "Insert statement raises #{error_class}" do
            assert insert_proc do
              raises_error?(error_class)
            end
          end
        end

      ensure
        session.close if session.connected?
      end
    end
  end
end

