module LD4L
  module WorksRDF
    class GetModelFromURI

      ##
      # Attempt to get metadata from the source of the URI via content negotiation.
      #
      # @param [String, RDF::URI] uri for the work
      #
      # @returns an instance of one of the generic work models
      def self.call( uri )
        uri = uri.to_s if uri.kind_of?(RDF::URI)

        # curl -L -D - -H "Accept: text/turtle" http://vivo.cornell.edu/individual/n56611
        http = Curl.get(uri) do |curl|
          curl.headers['Accept'] = 'text/turtle'
          curl.headers['Content-Type'] = 'text/turtle'
          curl.headers['Api-Version'] = '2.2'
          curl.follow_location = true
          curl.max_redirects = 3
          curl.connect_timeout = 30
          curl.useragent = "curb"
        end
        result = http.body_str
        header = http.header_str

        work_graph = RDF::Graph.new.from_ttl result
        repo_name = SecureRandom.uuid.to_sym
        # r = RDF::Repository.new
        r = ActiveTriples::Repositories.add_repository repo_name, RDF::Repository.new
        r << work_graph

        # Get work as a generic work
        the_work = self.get_generic_work( r, uri )
        types = []
        the_work.type.each do |t|
          types << t.to_s
        end

        # Try to get more specific work
        the_work = self.get_vivo_book( r, uri )    if types.include? RDFVocabularies::BIBO.Book.to_s
        the_work = self.get_schema_book( r, uri )  if types.include? RDF::SCHEMA.Book.to_s
        the_work
      end

      def self.get_generic_work( repo, uri )
        LD4L::WorksRDF::GenericWork.new(uri, :data => repo)
      end

      def self.get_vivo_book( repo, uri )
        LD4L::WorksRDF::VivoBook.new(uri, :data => repo)
      end

      def self.get_schema_book( repo, uri )
        LD4L::WorksRDF::SchemaBook.new(uri, :data => repo)
      end

    end
  end
end


