module ViewData
  module PG
    class Log < ::Log
      def tag!(tags)
        tags << :view_data_pg
        tags << :view_data
        tags << :library
      end
    end
  end
end
