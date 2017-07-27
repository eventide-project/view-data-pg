require_relative '../../automated_init'

context "Primary Key" do
  context "Get Columns" do
    context "Telemetry" do
      table = Controls::Table.name

      get_columns = View::Postgres::PrimaryKey::GetColumns.build

      telemetry_sink = View::Postgres::PrimaryKey::GetColumns.register_telemetry_sink(get_columns)

      columns = get_columns.(table)

      context "Telemetry Record" do
        record = telemetry_sink.one_record

        test "Is recorded" do
          refute(record.nil?)
        end

        test "Signal name" do
          assert(record.signal == :columns_queried)
        end

        test "Table" do
          assert(record.data.table == table)
        end

        test "Columns" do
          assert(record.data.columns == columns)
        end
      end
    end
  end
end
