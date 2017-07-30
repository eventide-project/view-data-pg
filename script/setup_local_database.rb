require_relative '../init'

require 'view_data/pg/controls'

ViewData::PG::Controls::Table.create(drop: true)
ViewData::PG::Controls::Table::AllDataTypes.create(drop: true)
ViewData::PG::Controls::Table::CompositePrimaryKey.create(drop: true)
