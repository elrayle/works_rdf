module LD4L
  module WorksRDF
    class GetMetadataFromVivoURI

      ##
      # Get display metadata via content negotiation from an URI known to return VIVO produced triples
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
        model      = LD4L::WorksRDF::PopulateVivoModelFromRepository.call(uri,repository)
        metadata   = LD4L::WorksRDF::GetMetadataFromVivoModel.call(model)
        metadata

      end
    end
  end
end
