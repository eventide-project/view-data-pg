module View
  module Postgres
    module Controls
      module Row
        module Get
          def self.call(id)
            table = Table.name

            session = Session.get

            statement = "SELECT * FROM #{table} WHERE id = $1"

            result = session.execute(statement, [id])

            rows = result.to_a

            data = rows[0]

            return nil if data.nil?

            data.keys.each do |name|
              data[name.to_sym] = data.delete(name.to_s)
            end

            data
          end
        end
      end
    end
  end
end
