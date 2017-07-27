module View
  module Postgres
    module Messages
      module Commands
        class Insert
          include Messaging::Message

          attribute :table, String
          attribute :primary_key
          attribute :data, Hash, default: proc { Hash.new }
        end

        class Update
          include Messaging::Message

          attribute :table, String
          attribute :primary_key
          attribute :data, Hash, default: proc { Hash.new }
        end

        class Delete
          include Messaging::Message

          attribute :table, String
          attribute :primary_key
        end
      end
    end
  end
end
