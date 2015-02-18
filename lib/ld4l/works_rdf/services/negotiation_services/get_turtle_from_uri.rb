module LD4L
  module WorksRDF
    class GetTurtleFromURI

      ##
      # Get triples as turtle populated from the URI via content negotiation.
      #
      # @param [String, RDF::URI] uri for the work
      #
      # @returns a string holding triples as turtle
      def self.call( uri )
        raise ArgumentError, 'uri argument must be a uri string or an instance of RDF::URI'  unless
            uri.kind_of?(String) && uri.size > 0 || uri.kind_of?(RDF::URI)

        uri = uri.to_s if uri.kind_of?(RDF::URI)

        http = Curl.get(uri) do |curl|
          curl.headers['Accept'] = 'text/turtle'
          curl.headers['Content-Type'] = 'text/turtle'
          curl.headers['Api-Version'] = '2.2'
          curl.follow_location = true
          curl.max_redirects = 3
          curl.connect_timeout = 30
          curl.useragent = "curb"
        end
        header = http.header_str
        response_content_type = LD4L::WorksRDF::ResponseHeader.get_content_type(header)
        raise EncodingError, "uri returned results of type '#{response_content_type}' instead of expected 'text/turtle'" unless response_content_type == 'text/turtle'

        result = http.body_str
        result
      end
    end
  end
end


