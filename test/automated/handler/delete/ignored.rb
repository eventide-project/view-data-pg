require_relative '../../automated_init'

context "Handler" do
  context "Delete Command" do
    context "Ignored" do
      id = Controls::PrimaryKey::UUID.example

      command = Controls::Commands::Delete.example(primary_key: id)

      handler = ViewData::PG::Handler.build
      handler.(command)

      row = Controls::Row::Get.(id)

      test "Row remains absent" do
        assert(row.nil?)
      end
    end
  end
end
