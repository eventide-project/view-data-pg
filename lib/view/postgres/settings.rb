module View
  module Postgres
    class Settings < MessageStore::Postgres::Settings
      def self.data_source
        'settings/view_postgres.json'
      end
    end
  end
end
