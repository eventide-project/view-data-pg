require_relative '../../automated_init'

context "Handle Commands" do
  context "Insert" do
    context "Ignored" do
      id = Identifier::UUID::Random.get

      Controls::Row::Put.(id, number: 11)

      insert = Controls::Commands::Insert.example(primary_key: id)
      refute(insert.data[:number] == 11)

      handler = View::Postgres::Handlers::Commands::Insert.build

      handler.(insert)

      row = Controls::Row::Get.(id)

      test "Row is not altered" do
        assert(row[:number] == 11)
      end
    end
  end
end
