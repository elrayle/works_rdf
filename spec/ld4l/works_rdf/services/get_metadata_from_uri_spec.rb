require 'spec_helper'

describe 'LD4L::WorksRDF::GetMetadataFromURI' do

  describe "#call" do
    xit "should return nil if no triples found for uri" do
    end

    xit "should return nil when triples don't match any of the available models" do
    end

    it "should return instance of VivoWork when URI is from VIVO" do
      # uri = "http://vivo.cornell.edu/individual/n56611/n56611.ttl"
      uri = "http://vivo.cornell.edu/individual/n56611"
      the_work = LD4L::WorksRDF::GetModelFromURI.call(uri)
      the_metadata = LD4L::WorksRDF::GetMetadataFromVivoURI.call(uri)

      expect(the_metadata).to be_kind_of LD4L::WorksRDF::WorkMetadata
      expect(the_metadata.work_type).to eq :BOOK
      expect(the_metadata.model).to be_kind_of LD4L::WorksRDF::VivoBook
      expect(the_metadata.rdf_types).to include RDFVocabularies::BIBO.Book
      expect(the_metadata.title).to eq the_work.label.first
    end

    it "should return instance of SchemaWork when URI is from Worldcat OCLC" do
      # uri = "http://vivo.cornell.edu/individual/n56611/n56611.ttl"
      uri = "http://www.worldcat.org/oclc/276976"
      the_work = LD4L::WorksRDF::GetModelFromURI.call(uri)
      the_metadata = LD4L::WorksRDF::GetMetadataFromOclcURI.call(uri)

      expect(the_metadata).to be_kind_of LD4L::WorksRDF::WorkMetadata
      expect(the_metadata.work_type).to eq :BOOK
      expect(the_metadata.model).to be_kind_of LD4L::WorksRDF::SchemaBook
      expect(the_metadata.rdf_types).to include RDF::SCHEMA.Book
      expect(the_metadata.title).to eq the_work.title.first
    end

  end
end
