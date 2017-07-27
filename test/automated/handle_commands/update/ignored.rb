require_relative '../../automated_init'

context "Handle Commands" do
  context "Update" do
    context "Ignored" do
      id = Identifier::UUID::Random.get

      update = Controls::Commands::Update.example(primary_key: id)

      handler = View::Postgres::Handlers::Commands::Update.build

      handler.(update)

      row = Controls::Row::Get.(id)

      test "Non-existent row is ignored" do
        assert(row.nil?)
      end
    end
  end
end
