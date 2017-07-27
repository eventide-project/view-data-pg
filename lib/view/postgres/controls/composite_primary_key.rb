module View
  module Postgres
    module Controls
      module CompositePrimaryKey
        def self.primary_key
          [ID.example(1), ID.example(2)]
        end

        def self.column_names
          ['primary_key_1', 'primary_key_2']
        end
      end
    end
  end
end
