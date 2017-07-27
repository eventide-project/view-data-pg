module View
  module Postgres
    module Controls
      module Row
        module Put
          def self.call(id, number: nil, other_column: nil)
            number ||= 0

            table = Table.name
            data = Commands::Insert.data

            session = Session.get

            statement = "INSERT INTO #{table} VALUES ($1, $2, $3)"

            result = session.execute(statement, [id, number, other_column])

            rows = result.to_a

            rows[0]
          end
        end
      end
    end
  end
end
