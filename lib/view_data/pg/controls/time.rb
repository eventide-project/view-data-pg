module ViewData
  module PG
    module Controls
      Time = Clock::Controls::Time

      module Time
        module Local
          def self.example(time=nil, precision: nil)
            time = Raw.example(time)

            Time.example(time, precision: precision)
          end

          module Offset
            def self.name
              'CET'
            end

            def self.hours
              1
            end

            def self.seconds
              hours * 60 * 60
            end
          end

          module Raw
            def self.example(time=nil)
              time ||= Time::Raw.example

              ::Time.new(
                time.year,
                time.month,
                time.day,
                time.hour,
                time.min,
                time.sec,
                Offset.seconds
              )
            end
          end
        end
      end
    end
  end
end
