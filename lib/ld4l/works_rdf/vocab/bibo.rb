module RDFVocabularies
  class BIBO < RDF::Vocabulary("http://purl.org/ontology/bibo/")
    term :Book
    term :Document

    property :isbn10
    property :isbn13
    property :oclcnum
  end
end
