module LD4L
  module WorksRDF
    class BibframePerson < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="p"

      configure :type => RDFVocabularies::BF.Person,
                :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default

      property :label,  :predicate => RDFVocabularies::BF.label  # string

    end
  end
end