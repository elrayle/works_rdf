module LD4L
  module WorksRDF
    class BibframeOrganization < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      configure :type => RDFVocabularies::BF.Organization,
                :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default

      property :label,  :predicate => RDFVocabularies::BF.label  # string

    end
  end
end