module LD4L
  module WorksRDF
    class BibframeWork < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      configure :type => RDFVocabularies::BF.Work,
                :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default

      property :creator,      :predicate => RDFVocabularies::BF.creator,      :class_name => LD4L::WorksRDF::BibframePerson
      property :contributor,  :predicate => RDFVocabularies::BF.contributor,  :class_name => LD4L::WorksRDF::BibframePerson
    end
  end
end
