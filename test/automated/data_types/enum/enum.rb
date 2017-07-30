require_relative '../../automated_init'

context "Data Types" do
  context "Boolean" do
    Fixtures::DataType::CheckValue.(
      column: 'some_enum',
      value: Controls::Enum.example
    )

    Fixtures::DataType::CheckValue.(
      column: 'some_enum',
      value: Controls::Enum.alternate
    )

    Fixtures::DataType::InsertRaisesError.(
      PG::InvalidTextRepresentation,
      column: 'some_enum',
      value: Controls::Enum.unknown
    )
  end
end
