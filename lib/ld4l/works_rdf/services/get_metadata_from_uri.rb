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
        unless the_work.nil?
          the_metadata = LD4L::WorksRDF::WorkMetadata.new(the_work)
          the_metadata = self.populate_with_vivo_book(   the_metadata, the_work )  if the_metadata.rdf_types.include? RDFVocabularies::BIBO.Book.to_s
          the_metadata = self.populate_with_schema_book( the_metadata, the_work )  if the_metadata.rdf_types.include? RDF::SCHEMA.Book.to_s
        end
        the_metadata
      end

      def self.populate_with_vivo_book( the_metadata, the_work )
        # TODO: Could reach out to OCLC and get more info OR could make multiple calls to VIVO to get more info
        the_metadata.set_type_to_book
        the_metadata.title            = the_work.title.first
        the_metadata.pub_info         = "#{the_work.place_of_publication.first} : #{the_work.publisher.first.label.first}"
        the_metadata.oclc_id          = the_work.oclcnum.first
        the_metadata.source           = "VIVO"
        the_metadata.set_source_to_cornell_vivo
        the_metadata
      end

      def self.populate_with_schema_book( the_metadata, the_work )
        the_metadata.set_type_to_book
        the_metadata.title            = the_work.title.first
        the_metadata.author           = the_work.creator.first.full_name.first
        the_metadata.pub_date         = the_work.date_published.first
        the_metadata.pub_info         = "#{the_work.place_of_publication.first} : #{the_work.publisher.first}, #{the_work.date_published.first}"
        the_metadata.language         = the_work.in_language.first
        the_metadata.edition          = the_work.book_edition.first
        the_metadata.oclc_id          = the_work.oclcnum.first
        the_metadata.source           = "OCLC Worldcat"
        the_metadata.set_source_to_oclc
        the_metadata
      end

    end
  end
end
