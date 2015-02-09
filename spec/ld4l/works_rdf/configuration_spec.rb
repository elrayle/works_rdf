require 'spec_helper'

describe 'LD4L::WorksRDF' do

  describe '#configuration' do
    describe "base_uri" do
      context "when base_uri is not configured" do
        before do
          class DummyWork < LD4L::WorksRDF::VivoBook
            configure :type => RDFVocabularies::VIVO.Book, :base_uri => LD4L::WorksRDF.configuration.base_uri, :repository => :default
          end
        end
        after do
          Object.send(:remove_const, "DummyWork") if Object
        end
        it "should generate a Person URI using the default base_uri" do
          expect(DummyWork.new('1').rdf_subject.to_s).to eq "http://localhost/1"
        end
      end

      context "when uri ends with slash" do
        before do
          LD4L::WorksRDF.configure do |config|
            config.base_uri = "http://localhost/test_slash/"
          end
          class DummyWork < LD4L::WorksRDF::VivoBook
            configure :type => RDFVocabularies::VIVO.Book, :base_uri => LD4L::WorksRDF.configuration.base_uri, :repository => :default
          end
        end
        after do
          Object.send(:remove_const, "DummyWork") if Object
          LD4L::WorksRDF.reset
        end

        it "should generate a Person URI using the configured base_uri" do
          expect(DummyWork.new('1').rdf_subject.to_s).to eq "http://localhost/test_slash/1"
        end
      end

      context "when uri does not end with slash" do
        before do
          LD4L::WorksRDF.configure do |config|
            config.base_uri = "http://localhost/test_no_slash"
          end
          class DummyWork < LD4L::WorksRDF::VivoBook
            configure :type => RDFVocabularies::VIVO.Book, :base_uri => LD4L::WorksRDF.configuration.base_uri, :repository => :default
          end
        end
        after do
          Object.send(:remove_const, "DummyWork") if Object
          LD4L::WorksRDF.reset
        end

        it "should generate a Person URI using the configured base_uri" do
          expect(DummyWork.new('1').rdf_subject.to_s).to eq "http://localhost/test_no_slash/1"
        end
      end

      it "should return value of configured base_uri" do
        LD4L::WorksRDF.configure do |config|
          config.base_uri = "http://localhost/test_config/"
        end
        expect(LD4L::WorksRDF.configuration.base_uri).to eq "http://localhost/test_config/"
      end

      it "should return default base_uri when base_uri is reset" do
        LD4L::WorksRDF.configure do |config|
          config.base_uri = "http://localhost/test_config/"
        end
        expect(LD4L::WorksRDF.configuration.base_uri).to eq "http://localhost/test_config/"
        LD4L::WorksRDF.configuration.reset_base_uri
        expect(LD4L::WorksRDF.configuration.base_uri).to eq "http://localhost/"
      end

      it "should return default base_uri when all configs are reset" do
        LD4L::WorksRDF.configure do |config|
          config.base_uri = "http://localhost/test_config/"
        end
        expect(LD4L::WorksRDF.configuration.base_uri).to eq "http://localhost/test_config/"
        LD4L::WorksRDF.reset
        expect(LD4L::WorksRDF.configuration.base_uri).to eq "http://localhost/"
      end
    end

    describe "localname_minter" do
      context "when minter is nil" do
        before do
          class DummyWork < LD4L::WorksRDF::VivoBook
            configure :type => RDFVocabularies::VIVO.Book, :base_uri => LD4L::WorksRDF.configuration.base_uri, :repository => :default
          end
        end
        after do
          Object.send(:remove_const, "DummyWork") if Object
        end
        it "should use default minter in minter gem" do
          localname = ActiveTriples::LocalName::Minter.generate_local_name(
                  LD4L::WorksRDF::VivoBook, 10, {:prefix=>'default_'},
                  LD4L::WorksRDF.configuration.localname_minter )
          expect(localname).to be_kind_of String
          expect(localname.size).to eq 44
          expect(localname).to match /default_[a-zA-Z0-9]{8}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{12}/
        end
      end

      context "when minter is configured" do
        before do
          LD4L::WorksRDF.configure do |config|
            config.localname_minter = lambda { |prefix=""| prefix+'_configured_'+SecureRandom.uuid }
          end
          class DummyWork < LD4L::WorksRDF::VivoBook
            configure :type => RDFVocabularies::VIVO.Book, :base_uri => LD4L::WorksRDF.configuration.base_uri, :repository => :default
          end
        end
        after do
          Object.send(:remove_const, "DummyWork") if Object
          LD4L::WorksRDF.reset
        end

        it "should generate an Person URI using the configured localname_minter" do
          localname = ActiveTriples::LocalName::Minter.generate_local_name(
              LD4L::WorksRDF::VivoBook, 10,
              LD4L::WorksRDF::VivoBook.localname_prefix,
              &LD4L::WorksRDF.configuration.localname_minter )
          expect(localname).to be_kind_of String
          expect(localname.size).to eq 49
          expect(localname).to match /w_configured_[a-zA-Z0-9]{8}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{12}/
        end
      end
    end
  end


  describe "LD4L::WorksRDF::Configuration" do
    describe "#base_uri" do
      it "should default to localhost" do
        expect(LD4L::WorksRDF::Configuration.new.base_uri).to eq "http://localhost/"
      end

      it "should be settable" do
        config = LD4L::WorksRDF::Configuration.new
        config.base_uri = "http://localhost/test"
        expect(config.base_uri).to eq "http://localhost/test"
      end

      it "should be re-settable" do
        config = LD4L::WorksRDF::Configuration.new
        config.base_uri = "http://localhost/test/again"
        expect(config.base_uri).to eq "http://localhost/test/again"
        config.reset_base_uri
        expect(config.base_uri).to eq "http://localhost/"
      end
    end

    describe "#localname_minter" do
      it "should default to nil" do
        expect(LD4L::WorksRDF::Configuration.new.localname_minter).to eq nil
      end

      it "should be settable" do
        config = LD4L::WorksRDF::Configuration.new
        config.localname_minter = lambda { |prefix=""| prefix+'_configured_'+SecureRandom.uuid }
        expect(config.localname_minter).to be_kind_of Proc
      end

      it "should be re-settable" do
        config = LD4L::WorksRDF::Configuration.new
        config.localname_minter = lambda { |prefix=""| prefix+'_configured_'+SecureRandom.uuid }
        expect(config.localname_minter).to be_kind_of Proc
        config.reset_localname_minter
        expect(config.localname_minter).to eq nil
      end
    end
  end
end
