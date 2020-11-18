require_relative '../automated_init'

context "Handler" do
  context "Quote Table" do
    handler = ViewData::PG::Handler.build

    context "Non-namespaced Table" do
      table_name = 'table_name'

      quoted_table = handler.quote_table_name(table_name)

      test "Table name is double quoted" do
        assert(quoted_table == %{"#{table_name}"})
      end
    end

    context "Namespaced table" do
      namespace = 'table'
      table_name = 'name'

      quoted_table = handler.quote_table_name("#{namespace}.#{table_name}")

      test "Namespace and table names are both double quoted" do
        assert(quoted_table == %{"#{namespace}"."#{table_name}"})
      end
    end
  end
end
