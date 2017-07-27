require_relative '../../automated_init'

context "Primary Key" do
  context "Get Columns" do
    context "Single Column" do
      table = Controls::Table.name

      columns = View::Postgres::PrimaryKey::GetColumns.(table)

      test "Returns name of column" do
        assert(columns == ['id'])
      end
    end
  end
end
