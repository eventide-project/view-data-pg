require_relative '../../automated_init'

context "Handler" do
  context "Delete Command" do
    context "Deleted" do
      id = Controls::Row::Put.()

      command = Controls::Commands::Delete.example(identifier: id)

      handler = ViewData::PG::Handler.build
      handler.(command)

      row = Controls::Row::Get.(id)

      test "Row is deleted" do
        assert(row.nil?)
      end
    end
  end
end
