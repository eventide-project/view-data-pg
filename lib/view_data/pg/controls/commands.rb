module ViewData
  module PG
    module Controls
      module Commands
        module Create
          def self.example(identifier: nil, column_value: nil)
            identifier ||= PrimaryKey::UUID.example
            data = Data.example(column_value: column_value)

            ViewData::Controls::Messages::Create.example(
              name: Table.name,
              identifier: identifier,
              data: data
            )
          end
        end

        module Update
          def self.example(identifier: nil, column_value: nil)
            identifier ||= PrimaryKey::UUID.example
            data = Data.example(column_value: column_value)

            ViewData::Controls::Messages::Update.example(
              name: Table.name,
              identifier: identifier,
              data: data
            )
          end
        end

        module Delete
          def self.example(identifier: nil)
            identifier ||= PrimaryKey::UUID.example

            ViewData::Controls::Messages::Delete.example(
              name: Table.name,
              identifier: identifier
            )
          end
        end
      end
    end
  end
end
