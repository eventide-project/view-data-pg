module ViewData
  module PG
    module Controls
      module Data
        def self.example(column_value: nil)
          column_value ||= self.column_value

          {
            :some_column => column_value
          }
        end

        def self.column_value
          'some-column-value'
        end
      end
    end
  end
end
