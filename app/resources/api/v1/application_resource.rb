module Api
  module V1
    class ApplicationResource < JSONAPI::Resource
      abstract
      # An optional Meta object added to every request
      def meta(options)
        { copyright: "© #{Time.now.year} Radosław Stolarski" }
      end
    end
  end
end