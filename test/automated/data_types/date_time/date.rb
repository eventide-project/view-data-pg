require_relative '../../automated_init'

context "Data Types" do
  context "Date Time" do
    context "Date" do
      Fixtures::DataType::CheckValue.(
        column: 'some_date',
        value: Controls::Date::Raw.example
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_date',
        value: Controls::Date.example,
        result_value: Controls::Date::Raw.example
      )
    end
  end
end
