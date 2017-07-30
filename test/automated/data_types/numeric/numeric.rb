require_relative '../../automated_init'

context "Data Types" do
  context "Numeric" do
    context "Numeric" do
      Fixtures::DataType::CheckValue.(
        column: 'some_numeric_3_1',
        value: 111
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_numeric_3_1',
        value: 111.1
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_numeric_3_1',
        value: 111.11,
        result_value: 111.1
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_numeric_3_1',
        value: 111.19,
        result_value: 111.2
      )

      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_numeric_3_1',
        value: 1111.1
      )
    end
  end
end
