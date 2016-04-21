module LD4L
  module WorksRDF
    class VivoAuthorship < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="p"

      configure :type => RDFVocabularies::VIVO.Authorship,
                :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default

      property :relates,   :predicate => RDFVocabularies::VIVO.relates,  :class_name => LD4L::WorksRDF::VivoBook
    end
  end
end
