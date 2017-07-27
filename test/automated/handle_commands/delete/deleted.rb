require_relative '../../automated_init'

context "Handle Commands" do
  context "Delete" do
    context "Deleted" do
      id = Identifier::UUID::Random.get

      Controls::Row::Put.(id)

      delete = Controls::Commands::Delete.example(primary_key: id)

      handler = View::Postgres::Handlers::Commands.build

      handler.(delete)

      row = Controls::Row::Get.(id)

      test "Row is deleted" do
        assert(row.nil?)
      end
    end
  end
end
