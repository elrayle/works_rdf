module LD4L
  module WorksRDF
    class GetMetadataFromSolrQuery

      ##
      # Get display metadata via content negotiation from an Cornell Solr
      #
      # @param [String, RDF::URI] uri for the work
      #
      # @returns an instance of LD4L::WorksRDF::WorkMetadata populated with display metadata for the work located at the URI
      def self.call( solr_query_url, solr_field_translations, localname_prefix="" )
        raise ArgumentError, 'solr_query_url argument must be a uri string'  unless solr_query_url.kind_of?(String)

        results  = LD4L::WorksRDF::GetSolrResultsFromSolrQuery.call(solr_query_url)
        return LD4L::WorksRDF::SetErrorInMetadata.call(solr_query_url,'ERROR: Unable to retrieve SOLR documents from URI') unless results && results.size > 0

        results_hash = Hash.from_xml(results)
        solr_docs = results_hash["response"]["result"]["doc"]
        solr_docs = [ solr_docs ] unless solr_docs.is_a? Array

        metadata = []
        solr_docs.each do |solr_doc|
          metadata << LD4L::WorksRDF::GetMetadataFromSolrDoc.call(solr_doc, solr_field_translations)
        end
        metadata
      end
    end
  end
end
