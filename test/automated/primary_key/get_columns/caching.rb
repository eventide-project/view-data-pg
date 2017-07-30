require_relative '../../automated_init'

context "Primary Key" do
  context "Get Columns" do
    context "Caching" do
      table = Controls::Table.name

      get_columns = ViewData::PG::PrimaryKey::GetColumns.build

      telemetry_sink = ViewData::PG::PrimaryKey::GetColumns.register_telemetry_sink(get_columns)

      columns_uncached = get_columns.(table)
      columns_cached = get_columns.(table)

      test "Returns names of columns" do
        assert(columns_cached == columns_uncached)
      end

      test "Telemetry indicates SQL query was performed only once" do
        recorded_once = telemetry_sink.recorded_once? do |record|
          record.signal == :columns_queried
        end

        assert(recorded_once)
      end
    end
  end
end
