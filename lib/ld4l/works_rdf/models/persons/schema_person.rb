module LD4L
  module WorksRDF
    class SchemaPerson < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="p"

      configure :type => RDFVocabularies::VIVO.Authorship,
                :base_uri => LD4L::WorksRDF.configuration.base_uri

      property :familyName,   :predicate => RDF::SCHEMA.familyName
      property :givenName,    :predicate => RDF::SCHEMA.givenName
      property :fullName,     :predicate => RDF::SCHEMA.name
    end
  end
end
