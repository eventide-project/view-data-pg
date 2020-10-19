require_relative '../../automated_init'

context 'Handler' do
  context 'Formatting' do
    context 'Quote Table' do
      handler = ViewData::PG::Handler.build


      test 'non-namespaced table' do
        name = 'table_name'

        quoted_table = handler.quote_table_name(name)

        assert quoted_table == "\"#{name}\""
      end

      test 'namespaced table' do
        namespace = 'table'
        table = 'name'

        quoted_table = handler.quote_table_name("#{namespace}.#{table}")

        assert quoted_table == "\"table\".\"name\""
      end
    end
  end
end
