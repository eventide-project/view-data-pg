module ViewData
  module PG
    module Controls
      module Commands
        module Create
          def self.example(primary_key: nil, column_value: nil, table: nil)
            primary_key ||= PrimaryKey::UUID.example
            table ||= Table.name
            data = Data.example(column_value: column_value)

            ViewData::Commands::Controls::Create.example(
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

            ViewData::Commands::Controls::Update.example(
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

            ViewData::Commands::Controls::Delete.example(
              name: table,
              identifier: primary_key
            )
          end
        end
      end
    end
  end
end
