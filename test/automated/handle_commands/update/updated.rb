require_relative '../../automated_init'

context "Handle Commands" do
  context "Update" do
    context "Updated" do
      id = Identifier::UUID::Random.get

      Controls::Row::Put.(id, number: 11)

      update = Controls::Commands::Update.example(primary_key: id)
      refute(update.data[:number] == 11)

      handler = View::Postgres::Handlers::Commands.build

      handler.(update)

      row = Controls::Row::Get.(id)

      test "Row is updated" do
        refute(row[:number] == 11)
      end
    end
  end
end
