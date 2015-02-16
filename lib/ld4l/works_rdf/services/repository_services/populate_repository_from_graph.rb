module LD4L
  module WorksRDF
    class PopulateRepositoryFromGraph

      ##
      # Create an RDF::Repository populated from an RDF::Graph.
      #
      # @param [RDF::Graph] instance of RDF::Graph
      #
      # @returns a populated instance of repository holding triples from the passed in graph
      def self.call( graph )
        raise ArgumentError, 'graph argument must an instance of RDF::Graph'  unless
            graph.kind_of?(RDF::Graph)

        repo_name = SecureRandom.uuid.to_sym
        # r = RDF::Repository.new
        r = ActiveTriples::Repositories.add_repository repo_name, RDF::Repository.new
        r << graph
      end

    end
  end
end


