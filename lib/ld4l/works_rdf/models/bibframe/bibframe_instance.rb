module LD4L
  module WorksRDF
    class BibframeInstance < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      configure :type => RDFVocabularies::BF.Instance,
                :base_uri => LD4L::WorksRDF.configuration.base_uri

      property :instance_of,          :predicate => RDFVocabularies::BF.instanceOf,     :class_name => LD4L::WorksRDF::BibframeWork
      property :title,                :predicate => RDFVocabularies::BF.instanceTitle,  :class_name => LD4L::WorksRDF::BibframeTitle
      property :system_number,        :predicate => RDFVocabularies::BF.systemNumber,   :class_name => LD4L::WorksRDF::BibframeIdentifier    # has OCLC URI in one of these
      property :publication,          :predicate => RDFVocabularies::BF.publication,    :class_name => LD4L::WorksRDF::BibframeProvider
      property :provider_statement,   :predicate => RDFVocabularies::BF.providerStatement
      property :copyright_date,       :predicate => RDFVocabularies::BF.copyrightDate
      property :book_edition,         :predicate => RDFVocabularies::BF.edition
    end
  end
end

