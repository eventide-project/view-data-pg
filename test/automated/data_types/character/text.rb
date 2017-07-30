require_relative '../../automated_init'

context "Data Types" do
  context "Character" do
    context "Text" do
      Fixtures::DataType::CheckValue.(
        column: 'some_text',
        value: 'Textual data'
      )
    end
  end
end
