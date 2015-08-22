module LD4L
  module WorksRDF
    class GetMetadataFromSolrDoc

      # TODO This is Cornell specific.  Need a general processor of solr OR a callback to an institution specific processor.
      ##
      # Get metadata from solr document.
      #
      # @param [Hash] solr document
      # @param [Hash] translations identifying location in solr doc for metadata fields
      #
      # @returns an instance of one of the OCLC work models
      def self.call( solr_doc, solr_field_translations )
        flat_doc = flatten(solr_doc["arr"])
        flat_doc.merge! interpret_str(solr_doc["str"])
        metadata = self.populate_with_solr_values(flat_doc, solr_field_translations)
        metadata
      end

      def self.populate_with_solr_values( solr_doc, solr_field_translations )
        metadata = LD4L::WorksRDF::WorkMetadata.new()

        metadata.source           = "Cornell Library"
        metadata.set_source_to_cornell_library

        # metadata.format           = solr_doc["format"].upcase.to_sym
        metadata.set_type(solr_doc["format"])
        metadata.local_id         = solr_doc["id"]
        metadata.uri              = "https://newcatalog.library.cornell.edu/catalog/"+metadata.local_id
        metadata.title            = solr_doc["title"]
        metadata.author           = solr_doc["author"]
        metadata.pub_date         = solr_doc["pub_date_display"]
        metadata.pub_info         = solr_doc["pub_info_display"]
        metadata.language         = solr_doc["language_display"]
        metadata.edition          = solr_doc["edition_display"]

        other_ids = solr_doc["other_id_display"]
        oclc_id = other_ids.select { |id| id.start_with? "(OCoLC)" }
        metadata.oclc_id = oclc_id.first[7..-1] if oclc_id.size > 0

        metadata
      end

      def self.flatten( solr_doc )
        flat_hash = {}
        solr_doc.each do |h|
          name = h["name"]
          value = h["str"]
          flat_hash[name] = value
        end
        flat_hash
      end

      def self.interpret_str( str_field )
        flat_hash = {}
        flat_hash["id"] = str_field.first
        flat_hash["author"] = str_field[1] if str_field.size > 3
        flat_hash["title"] = str_field.last
        flat_hash
      end

    end
  end
end
