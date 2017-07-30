require_relative '../../automated_init'

context "Handler" do
  context "Update Command" do
    context "Ignored" do
      id = Controls::PrimaryKey::UUID.example

      value = SecureRandom.hex(7)

      command = Controls::Commands::Update.example(
        identifier: id,
        column_value: value
      )

      handler = ViewData::PG::Handler.build
      handler.(command)

      row = Controls::Row::Get.(id)

      test "Row is not inserted" do
        assert(row.nil?)
      end
    end
  end
end
