require_relative '../../automated_init'

context "Primary Key" do
  context "Get Columns" do
    context "Configure Receiver" do
      receiver = OpenStruct.new

      View::Postgres::PrimaryKey::GetColumns.configure(receiver)

      test "Sets get_primary_key_columns attribute" do
        cls = View::Postgres::PrimaryKey::GetColumns

        assert(receiver.get_primary_key_columns.instance_of?(cls))
      end
    end
  end
end
