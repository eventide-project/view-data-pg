require_relative '../../automated_init'

context "Data Types" do
  context "Character" do
    context "Varchar" do
      Fixtures::DataType::CheckValue.(
        column: 'some_varchar_3',
        value: '.'
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_varchar_3',
        value: '..'
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_varchar_3',
        value: '...'
      )

      Fixtures::DataType::InsertRaisesError.(
        PG::StringDataRightTruncation,
        column: 'some_varchar_3',
        value: '....'
      )
    end
  end
end
