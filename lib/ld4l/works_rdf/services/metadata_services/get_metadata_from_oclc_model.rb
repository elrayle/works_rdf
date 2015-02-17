module LD4L
  module WorksRDF
    class GetMetadataFromOclcModel

      ##
      # Get standard display metadata from a oclc model
      #
      # @param [String, RDF::URI] uri for the work
      # @param [Model] a oclc model
      #
      # @returns an instance of LD4L::WorksRDF::WorkMetadata
      def self.call( uri, model )
        raise ArgumentError, 'uri argument must be a uri string or an instance of RDF::URI'  unless
            uri.kind_of?(String) && uri.size > 0 || uri.kind_of?(RDF::URI)

        uri = uri.to_s if uri.kind_of?(RDF::URI)

        # TODO: Determine type of work from the model.  Right now, only processing books.
        metadata = self.populate_with_schema_book( model )  if model.type.include? RDF::SCHEMA.Book.to_s
        metadata.uri      = uri
        metadata.local_id = URI.parse(uri).path.split('/').last
        metadata
      end

      def self.populate_with_schema_book( model )
        metadata = LD4L::WorksRDF::WorkMetadata.new(model)
        metadata.set_type_to_book
        metadata.title            = model.title.first
        metadata.author           = model.creator.first.full_name.first
        metadata.pub_date         = model.date_published.first
        metadata.pub_info         = "#{model.place_of_publication.first} : #{model.publisher.first}, #{model.date_published.first}"
        metadata.language         = model.in_language.first
        metadata.edition          = model.book_edition.first
        metadata.oclc_id          = model.oclcnum.first
        metadata.source           = "OCLC Worldcat"
        metadata.set_source_to_oclc
        metadata
      end

    end
  end
end
