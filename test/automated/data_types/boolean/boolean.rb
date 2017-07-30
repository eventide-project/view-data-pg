require_relative '../../automated_init'

context "Data Types" do
  context "Boolean" do
    Fixtures::DataType::CheckValue.(
      column: 'some_boolean',
      value: false
    )

    Fixtures::DataType::CheckValue.(
      column: 'some_boolean',
      value: true
    )
  end
end
