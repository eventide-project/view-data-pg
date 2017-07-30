require_relative '../../automated_init'

context "Handler" do
  context "Update Command" do
    context "Composite Primary Key" do
      id_1, id_2 = Controls::Row::Put::CompositePrimaryKey.()

      value = SecureRandom.hex(7)

      command = Controls::Commands::Update.example(
        table: Controls::Table::CompositePrimaryKey.name,
        primary_key: [id_1, id_2],
        column_value: value
      )

      handler = ViewData::PG::Handler.build
      handler.(command)

      row = Controls::Row::Get::CompositePrimaryKey.([id_1, id_2])

      test "Row is inserted" do
        refute(row.nil?)
      end

      context "Columns" do
        test "id_1" do
          assert(row['id_1'] == id_1)
        end

        test "id_2" do
          assert(row['id_2'] == id_2)
        end

        test "some_column" do
          assert(row['some_column'] == value)
        end
      end
    end
  end
end
