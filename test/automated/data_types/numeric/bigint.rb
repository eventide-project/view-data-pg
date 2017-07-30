require_relative '../../automated_init'

context "Data Types" do
  context "Numeric" do
    context "bigint" do
      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_bigint',
        value: -9223372036854775809
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_bigint',
        value: -9223372036854775808
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_bigint',
        value: 9223372036854775807
      )

      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_bigint',
        value: 9223372036854775808
      )
    end
  end
end
