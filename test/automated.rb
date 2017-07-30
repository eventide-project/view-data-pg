require_relative 'test_init'

require 'test_bench/cli'

exclude_pattern = %r{\/_|sketch|(_init\.rb|_tests\.rb)\z} 

if ENV['SKIP_DATA_TYPE_TESTS'].to_s.match?(%r{\A(?:y|yes|t|true|1)\z}i)
  exclude_pattern = %r{data_types|#{exclude_pattern}}
end

TestBench::CLI.(
  tests_directory: './test/automated',
  exclude_pattern: exclude_pattern
) or exit 1
