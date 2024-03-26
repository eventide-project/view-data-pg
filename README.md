# view_data/pg

General library for constructing a "view" table in postgres from eventide events

## What is a "View"?

The term "view" in "view data" is referring to the concept of a [materialized view](https://en.wikipedia.org/wiki/Materialized_view). There are certain tasks which are hard to accomplish with the key storage nature of message streams. A common example would be rendering a user interface for a system built on an evented, service-oriented architecture. However, these data views are not limited to just that use case. Any time a service would require data to be in a different shape (tabular, relational, graph, etc) view data can be considered.

### View Data

The most common interaction with stored events occurs via [projecting events on to an entity](http://docs.eventide-project.org/user-guide/projection.html). View data is similar conceptually -- instead of projecting events on to an entity, you project them into persistent data storage.

This library facilitates that in a simple, safe, and idempotent way, by providing [Commands](http://docs.eventide-project.org/core-concepts/messages-and-messaging/commands-and-events.html) apropriate for persistent data modification and [Handlers](http://docs.eventide-project.org/core-concepts/services/handlers.html) for those commands.

## Usage

View data is a specialized form of component. As such, it is constructed and run in the same way as any other component. Three commands are provided, which include a consistent API for interacting with your persistent view data store:

 - `ViewData::Commands::Create`
 - `ViewData::Commands::Update`
 - `ViewData::Commands::Delete`

These commands have the following fields:

 - `identifier` the value for the primary key of the table. note: This is assumed to be `id`
 - `name` the name of the table
 - `data` a hash of column name to column value which will be used in the relevent operation.

### Example

A familiarity with the general structure of an eventide component is assumed. If not, please refer to the documentation here http://docs.eventide-project.org

```ruby
# Define a handler for the stream you wish to update your view data
module MyDataComponent
  module Handlers
    class Events
      include Messaging::Handle
      include Messaging::StreamName
      include Log::Dependency
      include MyOtherComponent::Messages::Events

      dependency :clock, Clock::UTC
      dependency :write, Messaging::Postgres::Write

      def configure
        Clock::UTC.configure(self)
        Messaging::Postgres::Write.configure(self)
      end

      category :my_data

      def table
        'my_table'
      end

      handle Added do |added|
        id = added.account_id
        create = ViewData::Commands::Create.build

        create.identifier = id
        create.name = table
        create.data = {
          name: added.name,
          currency: added.currency,
          created_at: clock.now,
          updated_at: clock.now
        }

        write.(create, stream_name(id))
      end

      handle Renamed do |renamed|
        id = renamed.account_id
        update = ViewData::Commands::Update.build

        update.identifier = id
        update.name = table
        update.data = {
          name: renamed.name,
          updated_at: clock.now
        }

        write.(update, stream_name(id))
      end

      handle Enabled do |enabled|
        id = enabled.account_id
        update = ViewData::Commands::Update.build

        update.identifier = id
        update.name = table
        update.data = {
          enabled: true,
          updated_at: clock.now
        }

        write.(update, stream_name(id))
      end

      handle Disabled do |disabled|
        id = disabled.account_id
        update = ViewData::Commands::Update.build

        update.identifier = id
        update.name = table
        update.data = {
          enabled: false
        }

        write.(update, stream_name(id))
      end
    end
  end
end

# Add a consumer
module MyDataComponent
  module Consumers
    class Events
      include Consumer::Postgres
      handler Handlers::Events

      identifier :my_data
    end
  end
end

# Add a consumer for the view_data commands
module MyDataComponent
  module Consumers
    class DataCommands
      include ReportError

      include Consumer::Postgres
      handler ViewData::PG::Handler
    end
  end
end

# Start both consumers
module MyDataComponent
  module Start
    def self.call
      Consumers::DataCommands.start('myData')
      Consumers::Events.start('myOtherStream')
    end
  end
end
```

## Considerations

- View data's primary use is in display, reporting, and analytics. It shouldn't be accessed by service logic, otherwise business logic decisions may be based on data that is already out of date.
- Idempotence is a consideration when processing event streams for the purposes of updating view data. The techniques typically used in service development are applicable in view data applications.

## License

The `view-data-pg` library is released under the [MIT License](https://github.com/eventide-project/view-data-pg/blob/master/MIT-License.txt).
