module LD4L
  module WorksRDF
    class BibframeTitle < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="t"

      configure :type => RDFVocabularies::BF.Title,
                :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default

      property :title_value,  :predicate => RDFVocabularies::BF.titleValue  # string
      property :subtitle,     :predicate => RDFVocabularies::BF.subtitle    # string
      property :label,        :predicate => RDFVocabularies::BF.label       # string

    end
  end
end