module View
  module Postgres
    module Session
      def self.get(settings: nil)
        settings ||= Settings.instance

        session = MessageStore::Postgres::Session.build(settings: settings)
        settings.set(session)
        session
      end

      def self.configure(receiver, session: nil, attr_name: nil)
        attr_name ||= :session

        session ||= self.get
        receiver.public_send("#{attr_name}=", session)
        session
      end
    end
  end
end
