require_relative '../../automated_init'

context 'Handler' do
  context 'Formatting' do
    context 'Quote Columns' do
      handler = ViewData::PG::Handler.build
      column_name = 'example_column'

      quoted_column = handler.quote_columns(column_name)

      test 'adds quotes to column name' do
        assert quoted_column == "\"#{column_name}\""
      end
    end
  end
end
