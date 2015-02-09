module LD4L
  module WorksRDF
    class WorkMetadata

      attr_reader   :work_type       # valid values:  :UNKNOWN, :BOOK, :VIDEO, :MUSIC
      attr_reader   :rdf_types
      attr_reader   :model
      attr_accessor :title
      attr_accessor :author
      attr_accessor :pub_date
      attr_accessor :pub_info
      attr_accessor :language
      attr_accessor :edition
      attr_accessor :oclc_id
      attr_reader   :source          # valid values:  :UNKNOWN, :OCLC, :CORNELL_VIVO, :CORNELL_LIBRARY, :STANFORD_LIBRARY
      attr_accessor :local_id
      attr_accessor :local_location
      attr_accessor :local_callnumber
      # attr_accessor :availability  # TODO: for Cornell only???

      def initialize( the_work )
        @work_type        = :UNKNOWN
        @rdf_types        = ""
        @model            = ""
        @title            = ""
        @author           = ""
        @pub_date         = ""
        @pub_info         = ""
        @language         = ""
        @edition          = ""
        @oclc_id          = ""
        @source           = :UNKNOWN
        @local_id         = ""
        @local_location   = ""
        @local_callnumber = ""
        unless the_work.nil?
          @model = the_work
          @rdf_types = []
          the_work.type.each do |t|
            rdf_types << t.to_s
          end
        end
      end

      def set_type_to_book
        @work_type = :BOOK
      end
      def is_book?
        return true if @work_type == :BOOK
        false
      end

      def set_type_to_video
        @work_type = :VIDEO
      end
      def is_video?
        return true if @work_type == :VIDEO
        false
      end

      def set_type_to_music
        @work_type = :MUSIC
      end
      def is_music?
        return true if @work_type == :MUSIC
        false
      end

      def set_source_to_cornell_vivo
        @source = :CORNELL_VIVO
      end
      def is_cornell_vivo?
        return true if @source == :CORNELL_VIVO
        false
      end

      def set_source_to_oclc
        @source = :OCLC
      end
      def is_oclc?
        return true if @source == :OCLC
        false
      end

      def set_source_to_cornell_library
        @source = :CORNELL_LIBRARY
      end
      def is_cornell_library?
        return true if @source == :CORNELL_LIBRARY
        false
      end

      def set_source_to_stanford_library
        @source = :STANFORD_LIBRARY
      end
      def is_stanford_library?
        return true if @source == :STANFORD_LIBRARY
        false
      end

    end
  end
end
