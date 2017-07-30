require_relative '../../automated_init'

context "Data Types" do
  context "Date Time" do
    context "Time" do
      context "Without Timezone" do
        Fixtures::DataType::CheckValue.(
          column: 'some_time_3',
          value: Controls::Time::Raw.example,
          result_value: '00:00:00'
        )

        Fixtures::DataType::CheckValue.(
          column: 'some_time_3',
          value: '12:34:56',
          result_value: '12:34:56'
        )
      end

      context "With Timezone" do
        Fixtures::DataType::CheckValue.(
          column: 'some_time_3_with_tz',
          value: Controls::Time::Local::Raw.example,
          result_value: '00:00:00+01'
        )

        Fixtures::DataType::CheckValue.(
          column: 'some_time_3_with_tz',
          value: '12:34:56+01',
          result_value: '12:34:56+01'
        )
      end
    end
  end
end
