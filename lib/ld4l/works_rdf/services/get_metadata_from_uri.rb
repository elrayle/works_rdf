require 'pry'
module LD4L
  module WorksRDF
    class GetMetadataFromURI

      ##
      # Attempt to get metadata from the source of the URI via content negotiation.
      #
      # @param [String, RDF::URI] uri for the work
      #
      # @returns an instance of one of the generic work models
      def self.call( uri )
        uri = uri.to_s if uri.kind_of?(RDF::URI)

        the_work = LD4L::WorksRDF::GetModelFromURI.call(uri)

        the_metadata = nil
        if( the_work )
          the_metadata = LD4L::WorksRDF::WorkMetadata.new(the_work)
          the_metadata = populate_with_vivo_book(   the_metadata, the_work )  if types.include? RDFVocabularies::BIBO.Book.to_s
          the_metadata = populate_with_schema_book( the_metadata, the_work )  if types.include? RDF::SCHEMA.Book.to_s
        end
        the_metadata
      end

    end
    
    def populate_with_vivo_book( the_metadata, the_work )
      # TODO: Could reach out to OCLC and get more info
      the_metadata.set_type_to_book
      the_metadata.title    = the_work.title
      the_metadata.author   = ""
      the_metadata.pub_date = ""
      the_metadata.pub_info = "#{the_work.placeOfPublication} : #{the_work.publisher.first.label}"
      the_metadata.language = ""
      the_metadata.edition  = ""
      the_metadata
    end

    def populate_with_schema_book( the_metadata, the_work )
      the_metadata.set_type_to_book
      the_metadata.title    = the_work.title
      the_metadata.author   = the_work.creator.first.full_name
      the_metadata.pub_date = the_work.datePublished
      the_metadata.pub_info = "#{the_work.place_ofPublication} : #{the_work.publisher}
      the_metadata.language = the_work.
      the_metadata.edition  = the_work.
      the_metadata
    end
  end
end


property :title,               :predicate => RDF::SCHEMA.name
property :creator,             :predicate => RDF::SCHEMA.creator,       :class_name => LD4L::WorksRDF::SchemaPerson           # author
property :bookEdition,         :predicate => RDF::SCHEMA.bookEdition
property :copyrightYear,       :predicate => RDF::SCHEMA.copyrightYear
property :datePublished,       :predicate => RDF::SCHEMA.datePublished
property :description,         :predicate => RDF::SCHEMA.description
property :genre,               :predicate => RDF::SCHEMA.genre
property :inLanguage,          :predicate => RDF::SCHEMA.inLanguage
property :publisher,           :predicate => RDF::SCHEMA.publisher
property :oclcnum,             :predicate => RDFVocabularies::LIBRARY.oclcnum
property :placeOfPublication,  :predicate => RDFVocabularies::LIBRARY.placeOfPublication
