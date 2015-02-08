module RDFVocabularies
  class VIVO < RDF::Vocabulary("http://vivoweb.org/ontology/core#")
    property :mostSpecificType
    property :dateTimeValue
    property :placeOfPublication
    property :publisher
    property :relatedBy
  end
end
