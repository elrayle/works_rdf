# LD4L::WorksRDF

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

### Examples

TBA

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

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ld4l-works_rdf/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
