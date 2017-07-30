module ViewData
  module PG
    module Controls
      module Row
        module Get
          def self.call(primary_key, table: nil)
            table ||= Table.name

            session = Session.build

            result = session.execute(<<~SQL, [primary_key])
              SELECT * FROM #{table} WHERE id = $1 LIMIT 1
            SQL

            session.close

            result.to_a[0]
          end

          module CompositePrimaryKey
            def self.call(ids)
              id_1, id_2 = ids

              table = Table::CompositePrimaryKey.name

              session = Session.build

              result = session.execute(<<~SQL, [id_1, id_2])
                SELECT * FROM #{table} WHERE id_1 = $1 AND id_2 = $2 LIMIT 1
              SQL

              session.close

              result.to_a[0]
            end
          end
        end
      end
    end
  end
end
