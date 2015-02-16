module LD4L
  module WorksRDF
    class BibframeIdentifier < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="i"

      configure :type => RDFVocabularies::BF.Identifier,
                :base_uri => LD4L::WorksRDF.configuration.base_uri

      property :identifier_scheme,  :predicate => RDFVocabularies::BF.identifierScheme  # uri
      property :identifier_value,   :predicate => RDFVocabularies::BF.identifierValue   # string

    end
  end
end
