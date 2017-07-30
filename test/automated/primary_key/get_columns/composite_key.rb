require_relative '../../automated_init'

context "Primary Key" do
  context "Get Columns" do
    context "Composite Key" do
      table = Controls::Table::CompositePrimaryKey.name

      columns = ViewData::PG::PrimaryKey::GetColumns.(table)

      test "Returns names of columns" do
        assert(columns == Controls::PrimaryKey::Composite.column_names)
      end
    end
  end
end
