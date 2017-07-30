module ViewData
  module PG
    module Controls
      module PrimaryKey
        module UUID
          def self.example
            ID::Random.example
          end

          def self.column_name
            'id'
          end
        end

        module Composite
          def self.example
            [UUID.example, UUID.example]
          end

          def self.column_names
            ['id_1', 'id_2']
          end
        end
      end
    end
  end
end
