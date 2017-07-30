require_relative '../../automated_init'

context "Data Types" do
  context "Numeric" do
    context "Real" do
      Fixtures::DataType::CheckValue.(
        column: 'some_real',
        value: 1e-37
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_real',
        value: 1e37
      )

      context "Rounding" do
        Fixtures::DataType::CheckValue.(
          column: 'some_real',
          value: 1.111111,
          result_value: 1.11111
        )

        Fixtures::DataType::CheckValue.(
          column: 'some_real',
          value: 1.111119,
          result_value: 1.11112
        )
      end
    end
  end
end
