module RDFVocabularies
  class VIVO < RDF::Vocabulary("http://vivoweb.org/ontology/core#")
    term :Authorship

    property :dateTimeValue
    property :placeOfPublication
    property :publisher
    property :relatedBy
    property :relates
  end
end
