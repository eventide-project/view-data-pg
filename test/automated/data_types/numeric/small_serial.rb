require_relative '../../automated_init'

context "Data Types" do
  context "Numeric" do
    context "Small Serial" do
      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_smallserial',
        value: -32769
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_smallserial',
        value: -32768
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_smallserial',
        value: 32767
      )

      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_smallserial',
        value: 32768
      )
    end
  end
end
