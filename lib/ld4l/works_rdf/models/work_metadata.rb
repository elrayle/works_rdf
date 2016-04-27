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

      def initialize( the_work=nil )

        # displayable:
        #    line 1     @titla  @pubdate (year only)
        #    line 2     @author
        #    line 3     @format   @pub_info   @language   @edition
        #    line 4     @local_location   @local_callnumber
        # sortable:     @title, @author, @pub_date (year only)
        # facetable:    @format, @author, @pub_date (year_only), @language, @subject, @subject_region, @subject_era, @genre, @fiction_or_non, @local_location, @local_callnumber

        @work_type        = :UNKNOWN
        @rdf_types        = ""
        @uri              = ""    #             :displayable (used as URL for link)
        @model            = ""    #             :stored
        @title            = ""    #             :displayable, :searchable, :sortable
        @subtitle         = ""    #             :displayable, :searchable
        @author           = ""    # :facetable, :displayable, :searchable, :sortable
        @pub_date         = ""    # :facetable, :displayable,              :sortable   (year only)
        @pub_info         = ""    #             :displayable, :searchable
        @language         = ""    # :facetable, :displayable
        # @subject          = ""  # :facetable
        # @subject_region   = ""  # :facetable
        # @subject_era      = ""  # :facetable
        # @genre            = ""  # :facetable
        # @fiction_or_non   = ""  # :facetable
        @edition          = ""    #             :displayable
        @oclc_id          = ""    #             :displayable
        @source_id        = :UNKNOWN
        @source           = ""
        @local_id         = ""
        @local_location   = ""    # :facetable
        @local_callnumber = ""    # :facetable
        @format           = ""    # :facetable, :displayable
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

      def generate_solr_doc
        solr_doc = {}

        solr_doc[:resource_title_ti]         = @title
        solr_doc[:resource_title_sort_ss]    = @title
        solr_doc[:resource_subtitle_ti]      = @subtitle
        solr_doc[:resource_author_ti]        = @author
        solr_doc[:resource_author_facet_sim] = @author
        solr_doc[:resource_author_sort_ss]   = @author
        # solr_doc[:resource_subject_tim]     = @subject
        solr_doc[:resource_pub_date_iti]     = @pub_date      # year only, e.g.:  2005
        solr_doc[:resource_pub_info]         = @pub_info      # format: "Champaign, IL :Human Kinetics, c2005."
        solr_doc[:resource_language]         = @language
        solr_doc[:resource_edition]          = @edition
        solr_doc[:resource_oclc_id]          = @oclc_id
        solr_doc[:resource_source_id]        = @source_id
        solr_doc[:resource_source]           = @source
        solr_doc[:resource_local_id]         = @local_id
        solr_doc[:resource_local_location]   = @local_location
        solr_doc[:resource_local_callnumber] = @local_callnumber
        solr_doc[:resource_profile_ss]       = serialize
        solr_doc
      end

      def load_from_solr_doc( solr_doc )
        deserialize solr_doc[:resource_profile_ss]  if solr_doc.has_key? :resource_profile_ss
      end

      def serialize
        attrs = {}
        attrs[:title]            = @title
        attrs[:subtitle]         = @subtitle
        attrs[:author]           = @author
        attrs[:pub_date]         = @pub_date
        attrs[:pub_info]         = @pub_info
        attrs[:language]         = @language
        attrs[:edition]          = @edition
        attrs[:oclc_id]          = @oclc_id
        attrs[:source_id]        = @source_id
        attrs[:source]           = @source
        attrs[:local_id]         = @local_id
        attrs[:local_location]   = @local_location
        attrs[:local_callnumber] = @local_callnumber
        attrs.to_json
      end

      def deserialize( serialization )
        attrs = JSON.parse serialization

        @title            = attrs["title"]
        @subtitle         = attrs["subtitle"]
        @author           = attrs["author"]
        @pub_date         = attrs["pub_date"]
        @pub_info         = attrs["pub_info"]
        @language         = attrs["language"]
        @edition          = attrs["edition"]
        @oclc_id          = attrs["oclc_id"]
        @source_id        = attrs["source_id"]
        @source           = attrs["source"]
        @local_id         = attrs["local_id"]
        @local_location   = attrs["local_location"]
        @local_callnumber = attrs["local_callnumber"]
        self
      end

      def set_type(format)       # TODO validate format, don't just use it
        @work_type = format.upcase.to_sym if format.is_a? String  # TODO sometimes format is an array (e.g. ["Thesis","Book"])
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
