require "spec_helper"

describe "LD4L::WorksRDF" do
  describe "#configure" do

    before do
      LD4L::WorksRDF.configure do |config|
        config.base_uri = "http://localhost/test/"
        config.localname_minter = lambda { |prefix=""| prefix+'_configured_'+SecureRandom.uuid }
      end
      class DummyWork < LD4L::WorksRDF::BiboBook
        configure :type => RDFVocabularies::BIBO.Book, :base_uri => LD4L::WorksRDF.configuration.base_uri, :repository => :default
      end
    end
    after do
      LD4L::WorksRDF.reset
      Object.send(:remove_const, "DummyWork") if Object
    end

    it "should return configured value" do
      config = LD4L::WorksRDF.configuration
      expect(config.base_uri).to eq "http://localhost/test/"
      expect(config.localname_minter).to be_kind_of Proc
    end

    it "should use configured value in BiboBook sub-class" do
      p = DummyWork.new('1')
      expect(p.rdf_subject.to_s).to eq "http://localhost/test/1"

      p = DummyWork.new(ActiveTriples::LocalName::Minter.generate_local_name(
                                   LD4L::WorksRDF::BiboBook, 10, 'foo',
                                   &LD4L::WorksRDF.configuration.localname_minter ))
      expect(p.rdf_subject.to_s.size).to eq 73
      expect(p.rdf_subject.to_s).to match /http:\/\/localhost\/test\/foo_configured_[a-zA-Z0-9]{8}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{12}/
    end
  end

  describe ".reset" do
    before :each do
      LD4L::WorksRDF.configure do |config|
        config.base_uri = "http://localhost/test/"
        config.localname_minter = lambda { |prefix=""| prefix+'_configured_'+SecureRandom.uuid }
      end
    end

    it "resets the configuration" do
      LD4L::WorksRDF.reset
      config = LD4L::WorksRDF.configuration
      expect(config.base_uri).to eq "http://localhost/"
      expect(config.localname_minter).to eq nil
    end
  end
end