require_relative '../../automated_init'

context "Data Types" do
  context "Date Time" do
    context "Timestamp" do
      context "Without Timezone" do
        raw_time = Controls::Timestamp::Raw.example

        Fixtures::DataType::CheckValue.(
          column: 'some_timestamp_3',
          value: raw_time,
          result_value: Controls::Timestamp::Local::Raw.example
        )

        Fixtures::DataType::CheckValue.(
          column: 'some_timestamp_3',
          value: Controls::Timestamp.example(precision: 3),
          result_value: Controls::Timestamp::Local::Raw.example
        )

        Fixtures::DataType::CheckValue.(
          column: 'some_timestamp_3',
          value: Controls::Timestamp.example(precision: 4),
          result_value: Controls::Timestamp::Local::Raw.example
        )
      end

      context "With Timezone" do
        local_raw_time = Controls::Timestamp::Local::Raw.example

        Fixtures::DataType::CheckValue.(
          column: 'some_timestamp_3_with_tz',
          value: local_raw_time
        )

        Fixtures::DataType::CheckValue.(
          column: 'some_timestamp_3_with_tz',
          value: Controls::Timestamp::Local.example(precision: 3),
          result_value: local_raw_time
        )

        Fixtures::DataType::CheckValue.(
          column: 'some_timestamp_3_with_tz',
          value: Controls::Timestamp::Local.example(precision: 4),
          result_value: local_raw_time
        )
      end
    end
  end
end
