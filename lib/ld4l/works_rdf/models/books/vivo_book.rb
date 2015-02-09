module LD4L
  module WorksRDF
    class VivoBook < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      configure :type => RDFVocabularies::BIBO.Book,
                :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default

      property :title,                :predicate => RDF::RDFS.label
      property :isbn10,               :predicate => RDFVocabularies::BIBO.isbn10
      property :isbn13,               :predicate => RDFVocabularies::BIBO.isbn13
      property :oclcnum,              :predicate => RDFVocabularies::BIBO.oclcnum
      property :most_specific_type,   :predicate => RDFVocabularies::VIVO.mostSpecificType
      property :date_time_value,      :predicate => RDFVocabularies::VIVO.dateTimeValue,       :cast => false
      property :place_of_publication, :predicate => RDFVocabularies::VIVO.placeOfPublication
      property :publisher,            :predicate => RDFVocabularies::VIVO.publisher,           :class_name => LD4L::WorksRDF::VivoPublisher
      property :relatedBy,            :predicate => RDFVocabularies::VIVO.relatedBy,           :class_name => LD4L::WorksRDF::VivoAuthorship       # author
    end
  end
end
