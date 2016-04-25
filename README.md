# LD4L::WorksRDF

[![Build Status](https://travis-ci.org/ld4l/works_rdf.png?branch=master)](https://travis-ci.org/ld4l/works_rdf) 
[![Coverage Status](https://coveralls.io/repos/ld4l/works_rdf/badge.png?branch=master)](https://coveralls.io/r/ld4l/works_rdf?branch=master)
[![Gem Version](https://badge.fury.io/rb/ld4l-works_rdf.svg)](http://badge.fury.io/rb/ld4l-works_rdf)
[![Dependency Status](https://www.versioneye.com/ruby/ld4l-works_rdf/0.0.4/badge.svg)](https://www.versioneye.com/ruby/ld4l-works_rdf/0.0.4)


The primary purpose of this gem is the extraction of basic display metadata from rdf triples for use
in a user interface.  It is assumed that if detailed metadata is required, the user will be redirected 
back to the original source.

This is a catch all gem to process metadata coming from library works.  It can process marcxml and rdf+mxl 
of selected ontologies.  It is expected that it will grow and be refined to be more robust and flexible 
over time as more ontologies are identified and various interpretations of ontologies is accounted for in
the processing code.

## Installation


Temporarily install gem from github until it is released.

```
gem 'ld4l-works_rdf', :git => 'git@github.com:ld4l/works_rdf.git', :branch => 'master'
```

<!-- Add this line to your application's Gemfile: -->
<!--
```
gem 'ld4l-works_rdf'
```
-->

And then execute:

    $ bundle
<!--
Or install it yourself as:

    $ gem install ld4l-works_rdf
-->

## Usage

**Caveat:** This rails engine is part of the LD4L Project and is being used in that context.  There is no guarantee 
that the code will work in a usable way outside of its use in LD4L Use Cases.


### Examples

If the ontology is unknown, you can try all known methods by calling the generic metadata extraction service.
```
item_metadata = LD4L::WorksRDF::AttemptGenericMetadataExtraction.call(uri)
```

If the URI is known to return marcxml, use the following service.
```
item_metadata = LD4L::WorksRDF::GetMetadataFromMarcxml.call(uri)
```

If the URI is known to return schema.org ontology as interpreted by oclc, use the following service.
```
item_metadata = LD4L::WorksRDF::GetMetadataFromOclcURI.call(uri)
```

If the URI is known to return bibo ontology as interpreted by vivo, use the following service.
```
item_metadata = LD4L::WorksRDF::GetMetadataFromVivoURI.call(uri)
```

### Configuration

####Example configuration and usage for base_uri and default localname_minter
```
LD4L::WorksRDF.reset
LD4L::WorksRDF.configure do |config|
  config.base_uri = "http://example.org/"
end

w = LD4L::WorksRDF::GenericWork.new(ActiveTriples::LocalName::Minter.generate_local_name(
              LD4L::WorksRDF::GenericWork, 10, {:prefix=>'w'} ))

puts w.dump :ttl

w = LD4L::WorksRDF::GenericWork.new(ActiveTriples::LocalName::Minter.generate_local_name(
              LD4L::WorksRDF::GenericWork, 10, {:prefix=>'w'},
              &LD4L::WorksRDF.configuration.localname_minter ))

puts w.dump :ttl
```
NOTE: If base_uri is not used, you need to restart your interactive environment (e.g. irb, pry).  Once the 
  GenericWork class is instantiated the first time, the base_uri for the class is set.  If you ran
  through the main Examples, the base_uri was set to the default base_uri.


Example triples created for a generic work with configured base_uri and default minter
```
<http://example.org/w45c9c85b-25af-4c52-96a4-cf0d8b70a768> a <http://schema.org/schema:Book> .
```

####Example configuration and usage for base_uri and configured localname_minter
```
LD4L::WorksRDF.configure do |config|
  config.base_uri = "http://example.org/"
  config.localname_minter = lambda { |prefix=""| prefix+'_configured_'+SecureRandom.uuid }
end

w = LD4L::WorksRDF::GenericWork.new(ActiveTriples::LocalName::Minter.generate_local_name(
              LD4L::WorksRDF::GenericWork, 10, 'w',
              &LD4L::WorksRDF.configuration.localname_minter ))

puts w.dump :ttl
```
NOTE: If base_uri is not used, you need to restart your interactive environment (e.g. irb, pry).  Once the 
  GenericWork class is instantiated the first time, the base_uri for the class is set.  If you ran
  through the main Examples, the base_uri was set to the default base_uri.


Example triples created for a person with configured base_uri and configured minter.
```
<http://example.org/w_configured_6498ba05-8b21-4e8c-b9d4-a6d5d2180966> a <http://schema.org/schema:Book> .
```

### Models

The LD4L::WorksRDF gem provides model definitions using the 
[ActiveTriples](https://github.com/ActiveTriples/ActiveTriples) framework extension of 
[ruby-rdf/rdf](https://github.com/ruby-rdf/rdf).  The following models are provided:

1. LD4L::WorksRDF::GenericWork - Reads triples into a graph without setting any properties.
1. LD4L::WorksRDF::BibframeWork - Implements a work from the Bibframe ontology
1. LD4L::WorksRDF::BibframeInstance - Implements an instance from the Bibframe ontology
1. LD4L::WorksRDF::Bibframe* - Other supporting classes from Bibframe ontology
1. LD4L::WorksRDF::BiboBook - Implements a BIBO Book
1. LD4L::WorksRDF::BiboDocument - Implements a BIBO Document
1. LD4L::WorksRDF::VivoBook - Implements VIVO extensions to BIBO Book
1. LD4L::WorksRDF::Vivo* - Other supporting classes from the VIVO ontology
1. LD4L::WorksRDF::SchemaBook - Implements a book from the schema ontology
1. LD4L::WorksRDF::Schema* - Other supporting classes from the schema ontology
1. LD4L::WorksRDF::OclcSchemaBook - Implements OCLC extensions to the schema Book

### Ontologies

The listed ontologies are used to represent the primary metadata about the annotations.
Other ontologies may also be used that aren't listed.
 
* [Bibframe](http://www.loc.gov/bibframe/)
* [schema](schema.org)
* [bibo](http://bibliontology.com/bibo/bibo.php#)
* [RDF](http://www.w3.org/TR/rdf-syntax-grammar/)
* [Dublin Core (DC)](http://dublincore.org/documents/dces/)
* [Dublin Core Terms (DCTERMS)](http://dublincore.org/documents/dcmi-terms/)


### Known Uses

[LD4L Virtual Collection engine](https://github.com/ld4l/ld4l_virtual_collection)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ld4l-works_rdf/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

