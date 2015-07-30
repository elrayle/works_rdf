require 'rdf'
require 'active_triples'
require 'active_triples/local_name'
require 'active_triples/solrizer'
require 'curb'
require	'linkeddata'
require 'ld4l/works_rdf/vocab/bibo'
require 'ld4l/works_rdf/vocab/vivo'
require 'ld4l/works_rdf/vocab/vitro'
require 'ld4l/works_rdf/vocab/library'
require 'ld4l/works_rdf/vocab/bf'
require 'ld4l/works_rdf/version'


module LD4L
  module WorksRDF

    # Methods for configuring the GEM
    class << self
      attr_accessor :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.reset
      @configuration = Configuration.new
    end

    def self.configure
      yield(configuration)
    end


    # RDF vocabularies
    autoload :BIBO,                        'ld4l/works_rdf/vocab/bibo'
    autoload :VIVO,                        'ld4l/works_rdf/vocab/vivo'
    autoload :LIBRARY,                     'ld4l/works_rdf/vocab/library'
    autoload :BF,                          'ld4l/works_rdf/vocab/bf'

    # autoload classes
    autoload :Configuration,               'ld4l/works_rdf/configuration'

    # autoload model classes
    autoload :GenericWork,                 'ld4l/works_rdf/models/generic_work'
    autoload :WorkMetadata,                'ld4l/works_rdf/models/work_metadata'

    # autoload bibo model classes
    autoload :BiboBook,                    'ld4l/works_rdf/models/bibo/bibo_book'
    autoload :BiboDocument,                'ld4l/works_rdf/models/bibo/bibo_document'
    autoload :VivoBook,                    'ld4l/works_rdf/models/bibo/vivo_book'
    autoload :VivoAuthorship,              'ld4l/works_rdf/models/bibo/vivo_authorship'

    # autoload schema model classes
    autoload :SchemaBook,                  'ld4l/works_rdf/models/schema/schema_book'
    autoload :SchemaPerson,                'ld4l/works_rdf/models/schema/schema_person'
    autoload :SchemaPublisher,             'ld4l/works_rdf/models/schema/schema_publisher'
    autoload :OclcSchemaBook,              'ld4l/works_rdf/models/schema/oclc_schema_book'

    # autoload bibframe model classes
    autoload :BibframeWork,                'ld4l/works_rdf/models/bibframe/bibframe_work'
    autoload :BibframeInstance,            'ld4l/works_rdf/models/bibframe/bibframe_instance'
    autoload :BibframeIdentifier,          'ld4l/works_rdf/models/bibframe/bibframe_identifier'
    autoload :BibframeOrganization,        'ld4l/works_rdf/models/bibframe/bibframe_organization'
    autoload :BibframePerson,              'ld4l/works_rdf/models/bibframe/bibframe_person'
    autoload :BibframePlace,               'ld4l/works_rdf/models/bibframe/bibframe_place'
    autoload :BibframeProvider,            'ld4l/works_rdf/models/bibframe/bibframe_provider'
    autoload :BibframeTitle,               'ld4l/works_rdf/models/bibframe/bibframe_title'


    # autoload service classes
    autoload :GetMetadataFromMarcxmlURI,   'ld4l/works_rdf/services/get_metadata_from_marcxml_uri'
    autoload :GetMetadataFromVivoURI,      'ld4l/works_rdf/services/get_metadata_from_vivo_uri'
    autoload :GetMetadataFromOclcURI,      'ld4l/works_rdf/services/get_metadata_from_oclc_uri'
    autoload :AttemptGenericMetadataExtraction, 'ld4l/works_rdf/services/attempt_generic_metadata_extraction'

    autoload :GetModelFromURI,             'ld4l/works_rdf/services/get_model_from_uri'

    # autoload conversion service classes
    autoload :GetRdfxmlFromMarcxml,        'ld4l/works_rdf/services/conversion_services/get_rdfxml_from_marcxml'

    # autoload metadata service classes
    autoload :GetMetadataFromGenericModel, 'ld4l/works_rdf/services/metadata_services/get_metadata_from_generic_model'
    autoload :GetMetadataFromBibframeModels,'ld4l/works_rdf/services/metadata_services/get_metadata_from_bibframe_models'
    autoload :GetMetadataFromOclcModel,    'ld4l/works_rdf/services/metadata_services/get_metadata_from_oclc_model'
    autoload :GetMetadataFromVivoModel,    'ld4l/works_rdf/services/metadata_services/get_metadata_from_vivo_model'
    autoload :GetMetadataFromBiboModel,    'ld4l/works_rdf/services/metadata_services/get_metadata_from_bibo_model'
    autoload :SetErrorInMetadata,          'ld4l/works_rdf/services/metadata_services/set_error_in_metadata'

    # autoload model service classes
    autoload :PopulateGenericModelFromRepository,  'ld4l/works_rdf/services/model_services/populate_generic_model_from_repository'
    autoload :PopulateBibframeModelsFromRepository,'ld4l/works_rdf/services/model_services/populate_bibframe_models_from_repository'
    autoload :PopulateOclcModelFromRepository,     'ld4l/works_rdf/services/model_services/populate_oclc_model_from_repository'
    autoload :PopulateVivoModelFromRepository,     'ld4l/works_rdf/services/model_services/populate_vivo_model_from_repository'

    # autoload negotiation service classes
    autoload :GetMarcxmlFromURI,           'ld4l/works_rdf/services/negotiation_services/get_marcxml_from_uri'
    autoload :GetTurtleFromURI,            'ld4l/works_rdf/services/negotiation_services/get_turtle_from_uri'
    autoload :GetRdfxmlFromURI,            'ld4l/works_rdf/services/negotiation_services/get_rdfxml_from_uri'
    autoload :ResponseHeader,              'ld4l/works_rdf/services/negotiation_services/response_header'

    # autoload repository service classes
    autoload :PopulateRepositoryFromGraph, 'ld4l/works_rdf/services/repository_services/populate_repository_from_graph'
    autoload :PopulateGraphFromRdfxml,     'ld4l/works_rdf/services/repository_services/populate_graph_from_rdfxml'
    autoload :PopulateGraphFromTurtle,     'ld4l/works_rdf/services/repository_services/populate_graph_from_turtle'



    def self.class_from_string(class_name, container_class=Kernel)
      container_class = container_class.name if container_class.is_a? Module
      container_parts = container_class.split('::')
      (container_parts + class_name.split('::')).flatten.inject(Kernel) do |mod, class_name|
        if mod == Kernel
          Object.const_get(class_name)
        elsif mod.const_defined? class_name.to_sym
          mod.const_get(class_name)
        else
          container_parts.pop
          class_from_string(class_name, container_parts.join('::'))
        end
      end
    end

  end
end

