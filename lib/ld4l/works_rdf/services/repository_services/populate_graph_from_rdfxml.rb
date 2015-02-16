module LD4L
  module WorksRDF
    class PopulateGraphFromRdfxml

      ##
      # Create an RDF::Graph populated rdfxml triples
      #
      # @param [String] triples represented in rdfxml
      #
      # @returns a populated graph with passed in rdfxml triples
      def self.call( rdfxml )
        raise ArgumentError, 'rdfxml argument must be a non-empty string'  unless
            rdfxml.kind_of?(String) && rdfxml.size > 0

        RDF::Graph.new.from_rdfxml rdfxml
      end

    end
  end
end


