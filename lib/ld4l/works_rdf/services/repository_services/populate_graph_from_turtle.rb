module LD4L
  module WorksRDF
    class PopulateGraphFromTurtle

      ##
      # Create an RDF::Graph populated turtle triples
      #
      # @param [String] triples represented in turtle
      #
      # @returns a populated graph with passed in turtle triples
      def self.call( turtle )
        raise ArgumentError, 'turtle argument must be a non-empty string'  unless
            turtle.kind_of?(String) && turtle.size > 0

        RDF::Graph.new.from_ttl turtle
      end
    end
  end
end


