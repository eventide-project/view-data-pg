require_relative '../../automated_init'

context "Handle Commands" do
  context "Delete" do
    context "Ignored" do
      id = Identifier::UUID::Random.get

      delete = Controls::Commands::Delete.example(primary_key: id)

      handler = View::Postgres::Handlers::Commands.build

      handler.(delete)

      row = Controls::Row::Get.(id)

      test "Non-existent row is ignored" do
        assert(row.nil?)
      end
    end
  end
end
