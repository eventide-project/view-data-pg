require_relative '../../automated_init'

context "Data Types" do
  context "UUID" do
    Fixtures::DataType::CheckValue.(
      column: 'some_uuid',
      value: Controls::ID::Incrementing.example
    )

    Fixtures::DataType::InsertRaisesError.(
      PG::InvalidTextRepresentation,
      column: 'some_uuid',
      value: 'not-a-uuid'
    )
  end
end
