require_relative '../../automated_init'

context "Primary Key" do
  context "Get Columns" do
    context "Composite Key" do
      table = Controls::CompositePrimaryKey::Table.name

      columns = View::Postgres::PrimaryKey::GetColumns.(table)

      test "Returns names of columns" do
        assert(columns == Controls::CompositePrimaryKey.column_names)
      end
    end
  end
end
