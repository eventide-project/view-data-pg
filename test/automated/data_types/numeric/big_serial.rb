require_relative '../../automated_init'

context "Data Types" do
  context "Numeric" do
    context "Big Serial" do
      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_bigserial',
        value: -9223372036854775809
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_bigserial',
        value: -9223372036854775808
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_bigserial',
        value: 9223372036854775807
      )

      Fixtures::DataType::InsertRaisesError.(
        PG::NumericValueOutOfRange,
        column: 'some_bigserial',
        value: 9223372036854775808
      )
    end
  end
end
