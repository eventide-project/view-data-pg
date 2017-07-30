module ViewData
  module PG
    module Controls
      module Commands
        module Create
          def self.example(primary_key: nil, column_value: nil, table: nil)
            primary_key ||= PrimaryKey::UUID.example
            table ||= Table.name
            data = Data.example(column_value: column_value)

            ViewData::Controls::Messages::Create.example(
              name: table,
              identifier: primary_key,
              data: data
            )
          end
        end

        module Update
          def self.example(primary_key: nil, column_value: nil, table: nil)
            primary_key ||= PrimaryKey::UUID.example
            table ||= Table.name
            data = Data.example(column_value: column_value)

            ViewData::Controls::Messages::Update.example(
              name: table,
              identifier: primary_key,
              data: data
            )
          end
        end

        module Delete
          def self.example(primary_key: nil, table: nil)
            primary_key ||= PrimaryKey::UUID.example
            table ||= Table.name

            ViewData::Controls::Messages::Delete.example(
              name: table,
              identifier: primary_key
            )
          end
        end
      end
    end
  end
end
