module LD4L
  module WorksRDF
    class GetMarcxmlFromURI

      ##
      # Get marcxml populated from the URI via content negotiation.
      #
      # @param [String, RDF::URI] uri for the work
      #
      # @returns a string holding marcxml
      def self.call( uri )
        raise ArgumentError, 'uri argument must be a uri string or an instance of RDF::URI'  unless
            uri.kind_of?(String) && uri.size > 0 || uri.kind_of?(RDF::URI)

        uri = uri.to_s if uri.kind_of?(RDF::URI)

        http = Curl.get(uri) do |curl|
          curl.headers['Accept'] = 'application/marcxml+xml'
          curl.headers['Content-Type'] = 'application/marcxml+xml'
          curl.headers['Api-Version'] = '2.2'
          curl.follow_location = true
          curl.max_redirects = 3
          curl.connect_timeout = 30
          curl.useragent = "curb"
        end
        header = http.header_str
        response_content_type = LD4L::WorksRDF::ResponseHeader.get_content_type(header)
        raise EncodingError, "uri returned results of type '#{response_content_type}' instead of expected 'application/marcxml+xml'"  unless response_content_type == 'application/marcxml+xml'

        result = http.body_str
        result
      end
    end
  end
end
