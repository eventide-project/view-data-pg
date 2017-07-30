require_relative '../../automated_init'

context "Data Types" do
  context "Numeric" do
    context "Double Precision" do
      Fixtures::DataType::CheckValue.(
        column: 'some_double_precision',
        value: 1e-307
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_double_precision',
        value: 1e308
      )

      context "Rounding" do
        Fixtures::DataType::CheckValue.(
          column: 'some_double_precision',
          value: 1.111111111111111,
          result_value: 1.11111111111111
        )

        Fixtures::DataType::CheckValue.(
          column: 'some_double_precision',
          value: 1.111111111111119,
          result_value: 1.11111111111112
        )
      end
    end
  end
end
