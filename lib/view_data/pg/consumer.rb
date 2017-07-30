module ViewData
  module PG
    class Consumer
      include ::Consumer::Postgres

      handler Handler
    end
  end
end
