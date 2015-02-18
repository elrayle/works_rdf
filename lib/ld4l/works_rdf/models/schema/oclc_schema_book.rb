module LD4L
  module WorksRDF
    class OclcSchemaBook < LD4L::WorksRDF::SchemaBook

      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      property :oclcnum,              :predicate => RDFVocabularies::LIBRARY.oclcnum
      property :place_of_publication, :predicate => RDFVocabularies::LIBRARY.placeOfPublication
    end
  end
end
