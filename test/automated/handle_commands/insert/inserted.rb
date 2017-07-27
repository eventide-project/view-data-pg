require_relative '../../automated_init'

context "Handle Commands" do
  context "Insert" do
    context "Inserted" do
      id = Identifier::UUID::Random.get
      insert = Controls::Commands::Insert.example(primary_key: id)

      handler = View::Postgres::Handlers::Commands.build

      handler.(insert)

      row = Controls::Row::Get.(id)

      test "Row is inserted" do
        refute(row.nil?)
      end

      context "Columns" do
        insert.data.each do |column_name, value|
          test column_name.to_s do
            assert(row[column_name] == value)
          end
        end
      end
    end
  end
end
