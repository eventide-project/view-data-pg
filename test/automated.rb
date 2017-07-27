require_relative 'test_init'

require 'test_bench/cli'

TestBench::CLI.(
  tests_directory: './test/automated',
  exclude_pattern: %r{\/_|sketch|(_init\.rb|_tests\.rb)\z}
) or exit 1
