module LD4L
  module GenericWorkRDF
    class GenericWork < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      configure :type => RDFVocabularies::BIBO.Book,
                :base_uri => LD4L::GenericWorkRDF.configuration.base_uri,
                :repository => :default

      property :title,              :predicate => RDF::RDFS.label
      property :isbn10,             :predicate => RDFVocabularies::BIBO.isbn10
      property :isbn13,             :predicate => RDFVocabularies::BIBO.isbn13
      property :oclcnum,            :predicate => RDFVocabularies::BIBO.oclcnum
      property :mostSpecificType,   :predicate => RDFVocabularies::VIVO.mostSpecificType
      property :dateTimeValue,      :predicate => RDFVocabularies::VIVO.dateTimeValue
      property :placeOfPublication, :predicate => RDFVocabularies::VIVO.placeOfPublication
      property :publisher,          :predicate => RDFVocabularies::VIVO.publisher
      property :relatedBy,          :predicate => RDFVocabularies::VIVO.relatedBy       # author
    end
  end
end
