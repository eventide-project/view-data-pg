ENV['LOG_TAGS'] ||= 'messaging,view_data_pg'

require_relative './interactive_init'

session = MessageStore::Postgres::Session.build(settings: ViewData::PG::Settings.instance)

write = Messaging::Postgres::Write.build(session: session)

sleep_interval = 0.5

loop do
  ids = 10.times.map do
    create = Controls::Commands::Create.example

    id = create.identifier

    write.(create, "someCategory:command-#{id}")

    sleep(sleep_interval)

    id
  end

  3.times do |i|
    ids.each do |id|
      column_value = "value-#{i + 1}"

      update = Controls::Commands::Update.example(primary_key: id, column_value: column_value)

      write.(update, "someCategory:command-#{id}")

      sleep(sleep_interval)
    end
  end

  ids.each do |id|
    delete = Controls::Commands::Delete.example(primary_key: id)

    write.(delete, "someCategory:command-#{id}")

    sleep(sleep_interval)
  end
end
