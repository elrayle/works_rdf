module LD4L
  module WorksRDF
    class BibframeProvider < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="p"

      configure :type => RDFVocabularies::BF.Provider,
                :base_uri => LD4L::WorksRDF.configuration.base_uri

      property :provider_date,  :predicate => RDFVocabularies::BF.providerDate    # string
      property :provider_name,  :predicate => RDFVocabularies::BF.providerName,  :class_name => LD4L::WorksRDF::BibframeOrganization    # string
      property :provider_place, :predicate => RDFVocabularies::BF.providerPlace, :class_name => LD4L::WorksRDF::BibframePlace

    end
  end
end