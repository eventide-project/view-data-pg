module ViewData
  module PG
    module Controls
      module Consumer
        def self.example
          Example.build
        end

        class Example
          include ::Consumer::Postgres

          handler ViewData::PG::Handler
        end
      end
    end
  end
end
