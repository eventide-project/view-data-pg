require_relative '../../automated_init'

context "Handler" do
  context "Create Command" do
    context "Inserted" do
      id = Controls::PrimaryKey::UUID.example

      value = SecureRandom.hex(7)

      command = Controls::Commands::Create.example(
        identifier: id,
        column_value: value
      )

      handler = ViewData::PG::Handler.build
      handler.(command)

      row = Controls::Row::Get.(id)

      test "Row is inserted" do
        refute(row.nil?)
      end

      context "Columns" do
        test "id" do
          assert(row['id'] == id)
        end

        test "some_column" do
          assert(row['some_column'] == value)
        end
      end
    end
  end
end
