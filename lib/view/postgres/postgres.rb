module View
  module Postgres
    def self.activate
      formats = {
        :text => 0,
        :binary => 1
      }

      PG::BasicTypeRegistry.alias_type(formats[:text], 'uuid', 'text')
    end
  end
end
