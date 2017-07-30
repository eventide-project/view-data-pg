require_relative '../../automated_init'

context "Data Types" do
  context "Numeric" do
    context "smallint" do
      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_smallint',
        value: -32769
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_smallint',
        value: -32768
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_smallint',
        value: 32767
      )

      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_smallint',
        value: 32768
      )
    end
  end
end
