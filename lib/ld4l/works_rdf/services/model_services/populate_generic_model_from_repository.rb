module LD4L
  module WorksRDF
    class PopulateGenericModelFromRepository

      ##
      # Create a OCLC model and populate it with metadata from the repository.
      #
      # @param [RDF::Repository] repository holding triples
      #
      # @returns an instance of one of the OCLC work models
      def self.call( uri, repository )

        # TODO: Move to common place because this code is repeated in each model_from_repository file
        # Get work as a generic work
        work = LD4L::WorksRDF::GenericWork.new(uri, :data => repository)
        types = []
        work.type.each do |t|
          types << t.to_s
        end

        # TODO: Need to support multiple types (e.g. book, music, video).  Currently only supporting books.
        work = LD4L::WorksRDF::BiboBook.new(uri, :data => repository)      if types.include? RDFVocabularies::BIBO.Book.to_s
        work = LD4L::WorksRDF::BiboDocument.new(uri, :data => repository)  if types.include? RDFVocabularies::BIBO.Document.to_s
        work = LD4L::WorksRDF::PopulateBibframeModelsFromRepository.call(uri,repository)  if types.include?(RDFVocabularies::BF.Work.to_s) || types.include?(RDFVocabularies::BF.Instance.to_s)
        work = LD4L::WorksRDF::SchemaBook.new(uri, :data => repository)    if types.include? RDF::SCHEMA.Book.to_s
        work
      end
    end
  end
end
