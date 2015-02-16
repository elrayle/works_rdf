module LD4L
  module WorksRDF
    class SetErrorInMetadata

      ##
      # Set an error message and basic metadata for an error state
      #
      # @param [String, RDF::URI] uri for the work
      # @param [String]  error message
      #
      # @returns an instance of LD4L::WorksRDF::WorkMetadata with error state set
      def self.call( uri, error_message )
        raise ArgumentError, 'uri argument must be a uri string or an instance of RDF::URI'  unless
            uri.kind_of?(String) && uri.size > 0 || uri.kind_of?(RDF::URI)

        # TODO it may make more sense for handling of error messages to be in the WorkMessage model itself instead of here
        metadata = LD4L::WorksRDF::WorkMetadata.new(nil)
        metadata.uri              = uri
        metadata.title            = uri
        metadata.error            = true
        metadata.error_message    = error_message
        metadata
      end

    end
  end
end
