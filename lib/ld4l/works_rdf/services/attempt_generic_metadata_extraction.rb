module LD4L
  module WorksRDF
    class AttemptGenericMetadataExtraction

      ##
      # Attempt to get metadata from the source of the URI via content negotiation.
      #
      # @param [String, RDF::URI] uri for the work
      #
      # @returns an instance of one of the generic work models
      def self.call( uri )
        raise ArgumentError, 'uri argument must be a uri string or an instance of RDF::URI'  unless
            uri.kind_of?(String) && uri.size > 0 || uri.kind_of?(RDF::URI)

        begin
          turtle     = LD4L::WorksRDF::GetTurtleFromURI.call(uri)
          graph      = LD4L::WorksRDF::PopulateGraphFromTurtle.call(turtle)
        rescue
          begin
            rdfxml     = LD4L::WorksRDF::GetRdfxmlFromURI.call(uri)
            graph      = LD4L::WorksRDF::PopulateGraphFromRdfxml.call(rdfxml)
          rescue
            metadata   = LD4L::WorksRDF::SetErrorInMetadata.call(uri,'ERROR: Unable to extract metadata as turtle or rdfxml from URI')
            return metadata
          end
        end

        repository = LD4L::WorksRDF::PopulateRepositoryFromGraph.call(graph) if graph
        metadata   = LD4L::WorksRDF::SetErrorInMetadata.call(uri,'ERROR: Unable to populate repository from graph') unless repository

        model      = LD4L::WorksRDF::PopulateGenericModelFromRepository.call(uri,repository) if repository
        metadata   = LD4L::WorksRDF::SetErrorInMetadata.call(uri,'ERROR: Unable to populate models from repository') unless model

        metadata   = LD4L::WorksRDF::GetMetadataFromGenericModel.call(uri,model) if model
        metadata

      end

    end
  end
end
