module LD4L
  module WorksRDF
    class SchemaBook < ActiveTriples::Resource

      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      configure :type => RDF::SCHEMA.Book,
                :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default

      property :title,                :predicate => RDF::SCHEMA.name
      property :creator,              :predicate => RDF::SCHEMA.creator,       :class_name => LD4L::WorksRDF::SchemaPerson           # author
      property :book_edition,         :predicate => RDF::SCHEMA.bookEdition
      property :copyright_year,       :predicate => RDF::SCHEMA.copyrightYear
      property :date_published,       :predicate => RDF::SCHEMA.datePublished
      property :description,          :predicate => RDF::SCHEMA.description
      property :genre,                :predicate => RDF::SCHEMA.genre
      property :in_language,          :predicate => RDF::SCHEMA.inLanguage
      property :publisher,            :predicate => RDF::SCHEMA.publisher
    end
  end
end
