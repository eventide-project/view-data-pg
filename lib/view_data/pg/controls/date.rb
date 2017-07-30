module ViewData
  module PG
    module Controls
      module Date
        def self.example(date=nil)
          date ||= Raw.example

          date.iso8601
        end

        module Raw
          def self.example
            ::Date.new(2000, 1, 1)
          end
        end
      end
    end
  end
end
