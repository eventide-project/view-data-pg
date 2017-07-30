require_relative '../../automated_init'

context "Data Types" do
  context "JSON" do
    context "Text" do
      text = Controls::JSON.text
      data = Controls::JSON.data

      Fixtures::DataType::CheckValue.(
        column: 'some_json_text',
        value: text,
        result_value: data
      )

      Fixtures::DataType::CheckValue.(
        column: 'some_json_text',
        value: Controls::JSON.data,
        result_value: nil
      )
    end
  end
end
