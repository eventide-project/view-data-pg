require_relative '../init'

require 'view_data/pg/controls'

ViewData::PG::Controls::Table::AllDataTypes.create(drop: true)
