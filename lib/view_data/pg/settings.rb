module ViewData
  module PG
    class Settings < MessageStore::Postgres::Settings
      def self.data_source
        'settings/view_data_pg.json'
      end
    end
  end
end
