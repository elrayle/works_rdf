module LD4L
  module WorksRDF
    class GetMetadataFromBiboModel

      ##
      # Get standard display metadata from an bibo model
      #
      # @param [String, RDF::URI] uri for the work
      # @param [Model] an bibo model
      #
      # @returns an instance of LD4L::WorksRDF::WorkMetadata
      def self.call( uri, model )
        raise ArgumentError, 'uri argument must be a uri string or an instance of RDF::URI'  unless
            uri.kind_of?(String) && uri.size > 0 || uri.kind_of?(RDF::URI)

        uri = uri.to_s if uri.kind_of?(RDF::URI)

        # TODO: Determine type of work from the model.  Right now, only processing books.
        metadata = self.populate_with_bibo_book( model )  if
            model.type.include?(RDFVocabularies::BIBO.Book.to_s) || model.type.include?(RDFVocabularies::BIBO.Document.to_s)
        metadata.uri      = uri
        metadata.local_id = URI.parse(uri).path.split('/').last
        metadata
      end

      def self.populate_with_bibo_book( model )
        # TODO: Could reach out to OCLC and get more info OR could make multiple calls to VIVO to get more info
        metadata = LD4L::WorksRDF::WorkMetadata.new(model)
        metadata.set_type_to_book
        if model.title && model.title.size > 0
          metadata.title            = model.title.first
        elsif model.label && model.label.size > 0
          metadata.title            = model.label.first
        end
        metadata.oclc_id          = model.oclcnum.first  if model.oclcnum && model.oclcnum.size > 0
        # metadata.source           = "BIBO"
        metadata.set_source_to_unknown
        metadata
      end
    end
  end
end
