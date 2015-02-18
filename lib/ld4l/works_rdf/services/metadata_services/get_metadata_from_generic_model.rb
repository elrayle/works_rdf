module LD4L
  module WorksRDF
    class GetMetadataFromGenericModel

      ##
      # Attempt to get standard display metadata from a various models.
      #
      # @param [String, RDF::URI] uri for the work
      # @param [Model] one of the supported models
      #
      # @returns an instance of one of the OCLC work models
      def self.call( uri, model )
        raise ArgumentError, 'uri argument must be a uri string or an instance of RDF::URI'  unless
            uri.kind_of?(String) && uri.size > 0 || uri.kind_of?(RDF::URI)

        uri = uri.to_s if uri.kind_of?(RDF::URI)

        work = model[:work]  if     model.kind_of? Hash
        work = model         unless model.kind_of? Hash

        # TODO: Move to common place because this code is repeated in each model_from_repository file
        # Get work as a generic work
        types = []
        work.type.each do |t|
          types << t.to_s
        end

        # TODO: Need to support multiple types (e.g. book, music, video).  Currently only supporting books.
        metadata = LD4L::WorksRDF::GetMetadataFromBiboModel.call(uri,model)   if types.include? RDFVocabularies::BIBO.Book.to_s
        metadata = LD4L::WorksRDF::GetMetadataFromBiboModel.call(uri,model)   if types.include? RDFVocabularies::BIBO.Document.to_s
        metadata = LD4L::WorksRDF::PopulateBibframeModelsFromRepository.call(uri,model)  if types.include? RDFVocabularies::BF.Work.to_s
        metadata = LD4L::WorksRDF::GetMetadataFromOclcModel.new(uri,model)    if types.include? RDF::SCHEMA.Book.to_s

        metadata.source = URI.parse(uri).host
        metadata.set_source_to_unknown

        metadata
      end
    end
  end
end
