module LD4L
  module WorksRDF
    class PopulateBibframeModelsFromRepository

      ##
      # Create a Bibframe model and populate it with metadata from the repository.
      #
      # @param [RDF::Repository] repository holding triples
      #
      # @returns an instance of one of the Bibframe work models
      def self.call( bibframe_work_uri, repository )
        raise ArgumentError, 'bibframe_work_uri argument must be a uri string or an instance of RDF::URI'  unless
            bibframe_work_uri.kind_of?(String) && bibframe_work_uri.size > 0 || bibframe_work_uri.kind_of?(RDF::URI)

        raise ArgumentError, 'repository argument must be an instance of RDF::Repository'  unless
            repository.kind_of?(RDF::Repository)

        bibframe_work_uri = RDF::URI(bibframe_work_uri) unless bibframe_work_uri.kind_of?(RDF::URI)

        # TODO: Move to common place because this code is repeated in each model_from_repository file
        # # Get work as a generic work
        # work = LD4L::WorksRDF::GenericWork.new(uri, :data => repository)
        # types = []
        # work.type.each do |t|
        #   types << t.to_s
        # end

        query = RDF::Query.new({
                                   :instance => {
                                       RDF.type =>  RDFVocabularies::BF.Instance,
                                       RDFVocabularies::BF.instanceOf => bibframe_work_uri,
                                   }
                               })
        instances = []
        results = query.execute(repository)
        results.each { |r| instances << r.to_hash[:instance] }
        instances

        work     = LD4L::WorksRDF::BibframeWork.new(bibframe_work_uri, :data => repository)
        instance = LD4L::WorksRDF::BibframeInstance.new(instances.first, :data=>repository)

        { :work => work, :instance => instance }
      end
    end
  end
end
