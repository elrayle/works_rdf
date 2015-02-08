module LD4L
  module WorksRDF
    class GenericWork < ActiveTriples::Resource

      attr_accessor :work_type            # valid values:  :UNKNOWN, :BOOK, :VIDEO, :MUSIC
      attr_accessor :work_model
      attr_accessor :title
      # attr_accessor :author
      # attr_accessor :pub_date
      # attr_accessor :pub_info
      # attr_accessor :language
      # attr_accessor :edition
      # attr_accessor :source          # valid values:  :OCLC, :VIVO, :CORNELL_LIBRARY, :STANFORD_LIBRARY
      # attr_accessor :availability  # TODO: for Cornell only???


      class << self; attr_reader :localname_prefix end
      @localname_prefix="w"

      configure :base_uri => LD4L::WorksRDF.configuration.base_uri,
                :repository => :default,
                :type => RDFVocabularies::BIBO.Book

    end
  end
end
