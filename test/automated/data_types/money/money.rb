require_relative '../../automated_init'

context "Data Types" do
  context "Money" do
    Fixtures::DataType::CheckValue.(
      column: 'some_money',
      value: "-$92,233,720,368,547,758.09",
      result_value: "$92,233,720,368,547,758.07"
    )

    Fixtures::DataType::CheckValue.(
      column: 'some_money',
      value: "-$92,233,720,368,547,758.08",
    )

    Fixtures::DataType::CheckValue.(
      column: 'some_money',
      value: "$92,233,720,368,547,758.07",
    )

    Fixtures::DataType::CheckValue.(
      column: 'some_money',
      value: "$92,233,720,368,547,758.08",
      result_value: "-$92,233,720,368,547,758.08"
    )
  end
end
