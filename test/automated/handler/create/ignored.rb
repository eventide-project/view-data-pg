require_relative '../../automated_init'

context "Handler" do
  context "Create Command" do
    context "Ignored" do
      id = Controls::Row::Put.()

      value = SecureRandom.hex(7)

      command = Controls::Commands::Create.example(
        primary_key: id,
        column_value: value
      )

      handler = ViewData::PG::Handler.build
      handler.(command)

      row = Controls::Row::Get.(id)

      test "Row is present" do
        refute(row.nil?)
      end

      context "Columns" do
        test "id" do
          assert(row['id'] == id)
        end

        test "some_column" do
          assert(row['some_column'] == Controls::Data.column_value)
          refute(row['some_column'] == value)
        end
      end
    end
  end
end

