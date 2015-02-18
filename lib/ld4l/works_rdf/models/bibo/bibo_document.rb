module LD4L
  module WorksRDF
    class BiboDocument < LD4L::WorksRDF::BiboBook

      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      configure :type => RDFVocabularies::BIBO.Document,
                :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default

    end
  end
end
