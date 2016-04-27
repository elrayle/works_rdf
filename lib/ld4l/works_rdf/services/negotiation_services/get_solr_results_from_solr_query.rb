module LD4L
  module WorksRDF
    class GetSolrResultsFromSolrQuery

      ##
      # Get solr documents populated from the solr query url via content negotiation.
      #
      # @param [String] solr_query_url for the work(s)
      #
      # @returns a string holding solr results which may include multiple solr documents
      def self.call( solr_query_url )
        raise ArgumentError, 'solr_query_url argument must be a uri string'  unless solr_query_url.kind_of?(String)

        http = Curl.get(solr_query_url) do |curl|
          curl.headers['Accept'] = 'application/xml'
          curl.headers['Api-Version'] = '2.2'
          curl.follow_location = true
          curl.max_redirects = 3
          curl.connect_timeout = 30
          curl.useragent = "curb"
        end
        header = http.header_str

        status = LD4L::WorksRDF::ResponseHeader.get_status(header)
        raise EncodingError, "Status #{status} returned from query"  unless status == '200'

        response_content_type = LD4L::WorksRDF::ResponseHeader.get_content_type(header)
        raise EncodingError, "uri returned results of type '#{response_content_type}' instead of expected 'application/xml'"  unless response_content_type == 'application/xml'

        results = http.body_str
        results
      end
    end
  end
end
