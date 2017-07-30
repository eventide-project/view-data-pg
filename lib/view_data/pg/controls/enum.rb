module ViewData
  module PG
    module Controls
      module Enum
        def self.example
          'some-enum-value'
        end

        def self.alternate
          'other-enum-value'
        end

        def self.unknown
          'unknown-enum-value'
        end
      end
    end
  end
end
