module LD4L
  module WorksRDF
    class SchemaPublisher < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="p"

      configure :type => RDFVocabularies::BGN.Agent,
                :base_uri => LD4L::WorksRDF.configuration.base_uri

      property :publisher_name,   :predicate => RDF::SCHEMA.name
    end
  end
end
