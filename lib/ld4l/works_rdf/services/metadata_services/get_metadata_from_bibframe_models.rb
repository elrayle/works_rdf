module LD4L
  module WorksRDF
    class GetMetadataFromBibframeModels

      ##
      # Get standard display metadata from a oclc model
      #
      # @param [Model] a oclc model
      #
      # @returns an instance of LD4L::WorksRDF::WorkMetadata
      def self.call( models )

        work     = models[:work]
        instance = models[:instance]

        metadata = LD4L::WorksRDF::WorkMetadata.new(instance)
        metadata.set_type_to_book   # TODO Hardcoding to book for now
        metadata.title            = instance.title.first.label.first       if instance.title && instance.title.first && instance.title.first.label
        metadata.title            = instance.title.first.title_value.first if instance.title && instance.title.first && instance.title.first.title_value
        metadata.subtitle         = instance.title.first.subtitle.first    if instance.title && instance.title.first && instance.title.first.subtitle
        metadata.title = "#{metadata.title} : #{metadata.subtitle}"        if metadata.subtitle && metadata.subtitle.size > 0
        metadata.title            = instance.title_statement.first         if instance.title_statement && instance.title_statement.first
        metadata.author           = work.creator.first.label.first
        metadata.pub_date         = instance.publication.first.provider_date.first
        metadata.pub_info         = instance.provider_statement.first
        # metadata.language         = model.in_language.first
        metadata.edition          = instance.book_edition.first

        system_numbers = instance.system_number
        system_numbers.each do |sysnum|
          uri = sysnum.rdf_subject.to_s
          if uri.match('.*\/oclc\/(.*)')
            parts = URI.parse(uri).path.split('/')
            metadata.oclc_id = parts.last     if parts.include?("oclc")
          end
        end

        metadata.source           = "Bibframe"
        # metadata.set_source_to_bibframe
        metadata
      end

    end
  end
end
