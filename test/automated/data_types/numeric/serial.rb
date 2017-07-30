require_relative '../../automated_init'

context "Data Types" do
  context "Numeric" do
    context "Serial" do
      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_serial',
        value: -2147483649
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_serial',
        value: -2147483648
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_serial',
        value: 2147483647
      )

      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_serial',
        value: 2147483648
      )
    end
  end
end
