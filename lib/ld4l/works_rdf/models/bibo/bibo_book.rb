module LD4L
  module WorksRDF
    class BiboBook < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      configure :type => RDFVocabularies::BIBO.Book,
                :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default

      property :title,                :predicate => RDF::DC11.title
      property :label,                :predicate => RDF::RDFS.label
      property :isbn10,               :predicate => RDFVocabularies::BIBO.isbn10
      property :isbn13,               :predicate => RDFVocabularies::BIBO.isbn13
      property :oclcnum,              :predicate => RDFVocabularies::BIBO.oclcnum
    end
  end
end
