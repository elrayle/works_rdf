module LD4L
  module WorksRDF
    class WorkMetadata

      attr_reader   :work_type            # valid values:  :UNKNOWN, :BOOK, :VIDEO, :MUSIC
      attr_reader   :rdf_types
      attr_reader   :model
      attr_accessor :title
      attr_accessor :author
      attr_accessor :pub_date
      attr_accessor :pub_info
      attr_accessor :language
      attr_accessor :edition
      attr_reader   :source          # valid values:  :OCLC, :VIVO, :CORNELL_LIBRARY, :STANFORD_LIBRARY
      # attr_accessor :availability  # TODO: for Cornell only???

      def initialize( the_work )
        @work_type = :UNKNOWN
        @model = the_work
        @rdf_types = []
        the_work.type.each do |t|
          rdf_types << t.to_s
        end
      end

      def set_type_to_book
        @work_type = :BOOK
      end
      def set_type_to_video
        @work_type = :VIDEO
      end
      def set_type_to_music
        @work_type = :MUSIC
      end

    end
  end
end