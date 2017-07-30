require_relative '../../automated_init'

context "Data Types" do
  context "Binary" do
    context "bytea" do
      Fixtures::DataType::CheckValue.(
        column: 'some_bytea',
        value: "\x03\x02\x01"
      )
    end
  end
end
