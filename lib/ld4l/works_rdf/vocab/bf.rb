module RDFVocabularies
  class BF < RDF::Vocabulary("http://bibframe.org/vocab/")
    term :Work
    term :Instance
    term :Identifier
    term :Organization
    term :Place
    term :Provider
    term :Title

    property :identifierScheme
    property :identifierValue
    property :instanceOf
    property :instanceTitle
    property :systemNumber
    property :publication
    property :providerStatement
    property :copyrightDate
    property :edition
    property :label
    property :providerDate
    property :providerName
    property :providerPlace
    property :titleStatement
    property :titleValue
    property :subtitle
    property :creator
  end
end
