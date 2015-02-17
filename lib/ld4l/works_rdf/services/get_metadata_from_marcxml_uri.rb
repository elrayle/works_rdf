module LD4L
  module WorksRDF
    class GetMetadataFromMarcxmlURI

      ##
      # Get display metadata via content negotiation from an URI known to return MARCXML
      #
      # @param [String, RDF::URI] uri for the work
      #
      # @returns an instance of LD4L::WorksRDF::WorkMetadata populated with display metadata for the work located at the URI
      def self.call( uri, localname_prefix="" )
        raise ArgumentError, 'uri argument must be a uri string or an instance of RDF::URI'  unless
            uri.kind_of?(String) && uri.size > 0 || uri.kind_of?(RDF::URI)

puts("*** Beginning Processing of #{uri}")

        baseuri = LD4L::WorksRDF.configuration.base_uri
        baseuri = "#{baseuri}/" unless baseuri.end_with?("/")

        document_id = URI.parse(uri).path.split('/').last

        bibframe_work_uri = "#{baseuri}#{localname_prefix}#{document_id}"

        marcxml    = LD4L::WorksRDF::GetMarcxmlFromURI.call(uri)
        metadata   = LD4L::WorksRDF::SetErrorInMetadata.call(uri,'ERROR: Unable to retrieve MARCXML from URI')      unless marcxml && marcxml.size > 0

        rdfxml     = LD4L::WorksRDF::GetRdfxmlFromMarcxml.call(marcxml,baseuri) if marcxml && marcxml.size > 0
        metadata   = LD4L::WorksRDF::SetErrorInMetadata.call(uri,'ERROR: Unable to convert MARCXML into RDFXMl')    unless rdfxml && rdfxml.size > 0

        graph      = LD4L::WorksRDF::PopulateGraphFromRdfxml.call(rdfxml)       if rdfxml  && rdfxml.size > 0
        metadata   = LD4L::WorksRDF::SetErrorInMetadata.call(uri,'ERROR: Unable to populate graph from RDFXML')     unless graph

        repository = LD4L::WorksRDF::PopulateRepositoryFromGraph.call(graph)    if graph
        metadata   = LD4L::WorksRDF::SetErrorInMetadata.call(uri,'ERROR: Unable to populate repository from graph') unless repository

        models     = LD4L::WorksRDF::PopulateBibframeModelsFromRepository.call(bibframe_work_uri,repository)   if repository
        metadata   = LD4L::WorksRDF::SetErrorInMetadata.call(uri,'ERROR: Unable to populate models from repository') unless models

        metadata   = LD4L::WorksRDF::GetMetadataFromBibframeModels.call(uri, models)   if models
puts("--- Completed Processing of #{uri}")
        metadata

      end
    end
  end
end
