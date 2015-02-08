module LD4L
  module GenericWorkRDF
    class SchemaBook < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      configure :type => RDF::SCHEMA.Book,
                :base_uri => LD4L::GenericWorkRDF.configuration.base_uri,
                :repository => :default

      property :title,               :predicate => RDF::SCHEMA.name
      property :creator,             :predicate => RDF::SCHEMA.creator           # author
      property :bookEdition,         :predicate => RDF::SCHEMA.bookEdition
      property :copyrightYear,       :predicate => RDF::SCHEMA.copyrightYear
      property :datePublished,       :predicate => RDF::SCHEMA.datePublished
      property :description,         :predicate => RDF::SCHEMA.description
      property :genre,               :predicate => RDF::SCHEMA.genre
      property :inLanguage,          :predicate => RDF::SCHEMA.inLanguage
      property :publisher,           :predicate => RDF::SCHEMA.publisher
      property :oclcnum,             :predicate => RDFVocabularies::LIBRARY.oclcnum
      property :placeOfPublication,  :predicate => RDFVocabularies::LIBRARY.placeOfPublication
    end
  end
end
