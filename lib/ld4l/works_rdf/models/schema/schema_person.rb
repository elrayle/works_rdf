module LD4L
  module WorksRDF
    class SchemaPerson < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="p"

      configure :type => RDFVocabularies::VIVO.Authorship,
                :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default

      property :family_name,   :predicate => RDF::SCHEMA.familyName
      property :given_name,    :predicate => RDF::SCHEMA.givenName
      property :full_name,     :predicate => RDF::SCHEMA.name
    end
  end
end
