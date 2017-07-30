require_relative './interactive_init'

session = MessageStore::Postgres::Session.build(settings: ViewData::PG::Settings.instance)

Actor::Supervisor.start do
  ViewData::PG::Consumer.start('someCategory:command', session: session)
end
