module ViewData
  module PG
    module Controls
      module Row
        module Get
          def self.call(identifier, table_name: nil)
            identifier = Array(identifier)
            table_name ||= Table.name

            session = Session.build

            result = session.execute(<<~SQL, identifier)
            SELECT * FROM #{table_name} WHERE id = $1 LIMIT 1
            SQL

            session.close

            result.to_a[0]
          end
        end
      end
    end
  end
end
