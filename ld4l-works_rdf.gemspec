# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ld4l/works_rdf/version'

Gem::Specification.new do |spec|
  spec.name          = "ld4l-works_rdf"
  spec.version       = LD4L::WorksRDF::VERSION
  spec.authors       = ["E. Lynette Rayle"]
  spec.email         = ["elr37@cornell.edu"]
  spec.platform      = Gem::Platform::RUBY
  spec.summary       = %q{Several RDF models for bibliographic works.}
  spec.description   = %q{LD4L Works RDF provides tools for modeling a bibliographic works as triples based on multiple ontologies and persisting to a triplestore.}
  spec.homepage      = "https://github.com/ld4l/works_rdf"
  spec.license       = "APACHE2"
  spec.required_ruby_version     = '>= 1.9.3'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_dependency('rdf')
  spec.add_dependency('active-triples')
  spec.add_dependency('active_triples-local_name')
  spec.add_dependency('active_triples-solrizer')
  spec.add_dependency('ld4l-foaf_rdf')

  spec.add_dependency('curb')

  spec.add_development_dependency('pry')
  spec.add_development_dependency('pry-byebug')
  spec.add_development_dependency('rdoc')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('coveralls')
  spec.add_development_dependency('guard-rspec')
  spec.add_development_dependency('webmock')

  spec.extra_rdoc_files = [
      "LICENSE.txt",
      "README.md"
  ]
end

