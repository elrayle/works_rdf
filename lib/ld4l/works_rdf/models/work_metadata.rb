module LD4L
  module WorksRDF
    class WorkMetadata

      attr_reader   :work_type       # valid values:  :UNKNOWN, :BOOK, :VIDEO, :MUSIC
      attr_reader   :rdf_types
      attr_reader   :model
      attr_accessor :uri
      attr_accessor :title
      attr_accessor :subtitle
      attr_accessor :author
      attr_accessor :pub_date
      attr_accessor :pub_info
      attr_accessor :language
      attr_accessor :edition
      attr_accessor :oclc_id
      attr_reader   :source_id       # valid values:  :UNKNOWN, :OCLC, :CORNELL_VIVO, :CORNELL_LIBRARY, :STANFORD_LIBRARY
      attr_accessor :source
      attr_accessor :local_id
      attr_accessor :local_location
      attr_accessor :local_callnumber
      # attr_accessor :availability  # TODO: for Cornell only???
      attr_accessor :error
      attr_accessor :error_message

      def initialize( the_work )
        @work_type        = :UNKNOWN
        @rdf_types        = ""
        uri               = ""
        @model            = ""
        @title            = ""
        @subtitle         = ""
        @author           = ""
        @pub_date         = ""
        @pub_info         = ""
        @language         = ""
        @edition          = ""
        @oclc_id          = ""
        @source_id        = :UNKNOWN
        @source           = ""
        @local_id         = ""
        @local_location   = ""
        @local_callnumber = ""
        @error            = false
        @error_message    = ""
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

      def set_source_to_unknown
        @source_id = :UNKNOWN
      end
      def is_source_unknown?
        return true if @source_id == :UNKNOWN
        false
      end

      def set_source_to_cornell_vivo
        @source_id = :CORNELL_VIVO
      end
      def is_cornell_vivo?
        return true if @source_id == :CORNELL_VIVO
        false
      end

      def set_source_to_oclc
        @source_id = :OCLC
      end
      def is_oclc?
        return true if @source_id == :OCLC
        false
      end

      def set_source_to_cornell_library
        @source_id = :CORNELL_LIBRARY
      end
      def is_cornell_library?
        return true if @source_id == :CORNELL_LIBRARY
        false
      end

      def set_source_to_stanford_library
        @source_id = :STANFORD_LIBRARY
      end
      def is_stanford_library?
        return true if @source_id == :STANFORD_LIBRARY
        false
      end

      def set_source_to_harvard_library
        @source_id = :HARVARD_LIBRARY
      end
      def is_harvard_library?
        return true if @source_id == :HARVARD_LIBRARY
        false
      end
    end
  end
end
