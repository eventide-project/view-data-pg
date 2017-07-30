require_relative '../../automated_init'

context "Data Types" do
  context "Character" do
    context "Char" do
      Fixtures::DataType::CheckValue.(
        column: 'some_char_3',
        value: '..',
        result_value: '.. '
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_char_3',
        value: '...'
      )

      Fixtures::DataType::InsertRaisesError.(
        PG::StringDataRightTruncation,
        column: 'some_char_3',
        value: '....'
      )
    end
  end
end
