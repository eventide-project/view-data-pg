ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

require 'test_bench'; TestBench.activate

require 'view_data/pg/controls'

require_relative './fixtures/fixtures_init'

Controls = ViewData::PG::Controls
