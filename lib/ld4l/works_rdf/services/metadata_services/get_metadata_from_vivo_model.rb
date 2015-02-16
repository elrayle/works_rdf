module LD4L
  module WorksRDF
    class GetMetadataFromVivoModel

      ##
      # Get standard display metadata from an vivo model
      #
      # @param [Model] an vivo model
      #
      # @returns an instance of LD4L::WorksRDF::WorkMetadata
      def self.call( model )

        # TODO: Determine type of work from the model.  Right now, only processing books.
        metadata = self.populate_with_vivo_book( model )  if model.type.include? RDFVocabularies::BIBO.Book.to_s
        metadata
      end

      def self.populate_with_vivo_book( model )
        # TODO: Could reach out to OCLC and get more info OR could make multiple calls to VIVO to get more info
        metadata = LD4L::WorksRDF::WorkMetadata.new(model)
        metadata.set_type_to_book
        metadata.title            = model.title.first
        metadata.pub_info         = "#{model.place_of_publication.first} : #{model.publisher.first.label.first}"
        metadata.oclc_id          = model.oclcnum.first
        metadata.source           = "VIVO"
        metadata.set_source_to_cornell_vivo
        metadata
      end
    end
  end
end
