module ViewData
  module PG
    class Settings < MessageStore::Postgres::Settings
      def self.data_source
        ENV['VIEW_DATA_SETTINGS_PATH'] || 'settings/view_data_pg.json'
      end
    end
  end
end
