require_relative '../../automated_init'

context "Handler" do
  context "Delete Command" do
    context "Composite Primary Key" do
      id_1, id_2 = Controls::Row::Put::CompositePrimaryKey.()

      command = Controls::Commands::Delete.example(
        table: Controls::Table::CompositePrimaryKey.name,
        primary_key: [id_1, id_2]
      )

      handler = ViewData::PG::Handler.build
      handler.(command)

      row = Controls::Row::Get::CompositePrimaryKey.([id_1, id_2])

      test "Row is deleted" do
        assert(row.nil?)
      end
    end
  end
end
