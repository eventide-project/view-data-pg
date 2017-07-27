require_relative '../automated_init'

context "Session" do
  context "Configure Receiver" do
    context "Session Not Given" do
      receiver = OpenStruct.new

      View::Postgres::Session.configure(receiver)

      test "New session is set on receiver" do
        assert(receiver.session.instance_of?(MessageStore::Postgres::Session))
      end
    end

    context "Session Given" do
      session = View::Postgres::Session.get

      receiver = OpenStruct.new

      View::Postgres::Session.configure(receiver, session: session)

      test "Sets the given session on receiver" do
        assert(receiver.session.equal?(session))
      end
    end

    context "Alternate Attribute Name Is Given" do
      receiver = OpenStruct.new

      View::Postgres::Session.configure(receiver, attr_name: :some_attr)

      test "Sets the given attribute, not `session'" do
        assert(receiver.some_attr.instance_of?(MessageStore::Postgres::Session))
        assert(receiver.session.nil?)
      end
    end
  end
end
