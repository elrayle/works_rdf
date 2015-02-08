require 'rdf'
require 'active_triples'
require 'active_triples/local_name'
require 'curb'
require	'linkeddata'
require 'ld4l/generic_work_rdf/vocab/bibo'
require 'ld4l/generic_work_rdf/vocab/vivo'
require 'ld4l/generic_work_rdf/vocab/library'
require 'ld4l/generic_work_rdf/version'


module LD4L
  module GenericWorkRDF

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
    autoload :BIBO,                  'ld4l/generic_work_rdf/vocab/bibo'
    autoload :VIVO,                  'ld4l/generic_work_rdf/vocab/vivo'
    autoload :LIBRARY,               'ld4l/generic_work_rdf/vocab/library'

    # autoload classes
    autoload :Configuration,         'ld4l/generic_work_rdf/configuration'

    # autoload model classes
    autoload :BiboBook,              'ld4l/generic_work_rdf/models/bibo_book'
    autoload :SchemaBook,            'ld4l/generic_work_rdf/models/schema_book'

    # autoload service classes
    autoload :GetMetadataFromURI,    'ld4l/generic_work_rdf/services/get_metadata_from_uri'

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

