module LD4L
  module WorksRDF
    class VivoPublisher < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="p"

      configure :type => RDF::FOAF.Agent,
                :base_uri => LD4L::WorksRDF.configuration.base_uri

      property :label,   :predicate => RDF::RDFS.label
    end
  end
end
