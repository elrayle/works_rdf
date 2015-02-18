module LD4L
  module WorksRDF
    class GenericWork < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      configure :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default

    end
  end
end
