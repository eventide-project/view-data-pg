module ViewData
  module PG
    module Controls
      module JSON
        def self.data
          {
            'someString' => 'some-string',
            'someNumber' => 1,
            'someList' => ['a', 'b', 'c'],
            'someNestedObject' => {
              'someNestedAttribute' => 'some-nested-value'
            }
          }
        end

        def self.text
          ::JSON.generate(data)
        end
      end
    end
  end
end
