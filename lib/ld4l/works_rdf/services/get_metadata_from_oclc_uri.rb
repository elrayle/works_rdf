module LD4L
  module WorksRDF
    class GetMetadataFromOclcURI

      ##
      # Get display metadata via content negotiation from an URI known to return OCLC produced triples
      #
      # @param [String, RDF::URI] uri for the work
      #
      # @returns an instance of LD4L::WorksRDF::WorkMetadata populated with display metadata for the work located at the URI
      def self.call( uri )
        raise ArgumentError, 'uri argument must be a uri string or an instance of RDF::URI'  unless
            uri.kind_of?(String) && uri.size > 0 || uri.kind_of?(RDF::URI)

        turtle     = LD4L::WorksRDF::GetTurtleFromURI.call(uri)
        graph      = LD4L::WorksRDF::PopulateGraphFromTurtle.call(turtle)
        repository = LD4L::WorksRDF::PopulateRepositoryFromGraph.call(graph)
        model      = LD4L::WorksRDF::PopulateOclcModelFromRepository.call(uri,repository)
        metadata   = LD4L::WorksRDF::GetMetadataFromOclcModel.call(uri,model)
        metadata

      end
    end
  end
end
