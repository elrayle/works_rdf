require 'pry'
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
        # uri = RDF::URI(uri) if uri.kind_of?(String)

        # curl -D - -H "Accept: application/json" http://vivo.cornell.edu/individual/individual24416/individual24416.jsonld
        # result = Kernel.system "curl -D - -H \"Accept: text/turtle\" #{uri}"
        http = Curl.get(uri) do |curl|
          curl.headers['Accept'] = 'text/turtle'
          curl.headers['Content-Type'] = 'text/turtle'
          curl.headers['Api-Version'] = '2.2'
          curl.follow_location = true
          curl.max_redirects = 1
          curl.useragent = "curb"
          curl.on_redirect do |easy|
            # puts http.header_str
            # easy.headers['Accept'] = 'text/ttl'
            # easy.headers['Content-Type'] = 'text/ttl'
            # easy.headers['Api-Version'] = '2.2'
            puts "set header again for redirect"
          end
        end
        result = http.body_str
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
        generic_work = LD4L::WorksRDF::GenericWork.new(uri, :data => repo)
        puts('After getting generic_work')
        generic_work
      end

      def self.get_vivo_book( repo, uri )
        vivo_work = LD4L::WorksRDF::VivoBook.new(uri, :data => repo)
        puts('After getting bibo_work')
        vivo_work
      end

      def self.get_schema_book( repo, uri )
        schema_work = LD4L::WorksRDF::SchemaBook.new(uri, :data => repo)
        puts('After getting schema_work')
        schema_work
      end


    end
  end
end

