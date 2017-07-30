require_relative '../../automated_init'

context "Data Types" do
  context "Numeric" do
    context "integer" do
      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_integer',
        value: -2147483649
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_integer',
        value: -2147483648
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_integer',
        value: 2147483647
      )

      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_integer',
        value: 2147483648
      )
    end
  end
end
