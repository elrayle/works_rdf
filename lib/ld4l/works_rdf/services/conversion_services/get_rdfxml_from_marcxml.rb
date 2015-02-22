module LD4L
  module WorksRDF
    class GetRdfxmlFromMarcxml

      ##
      # Get rdfxml from marcxml
      #
      # @param [String] marcxml to be converted
      #
      # @returns a string holding rdfxml triples
      def self.call( marcxml, baseuri )
        raise ArgumentError, 'marcxml argument must be a non-empty string'  unless
            marcxml.kind_of?(String) && marcxml.size > 0

        marcxml = marcxml.force_encoding('ASCII-8BIT').encode('UTF-8', :invalid => :replace, :undef => :replace, :replace => '?')

        # TODO: Where should tmp files be saved?  The following puts them in the lib directory
        uuid = SecureRandom.uuid
        rdfxml_file  = File.join(File.dirname(__FILE__), "tmp_#{uuid}.rdf")
        marcxml_file = File.join(File.dirname(__FILE__), "tmp_#{uuid}.marcxml")
        File.open(marcxml_file, 'w') { |file| file.write marcxml; file.close }

        saxon = File.join(File.dirname(__FILE__), 'saxon', 'saxon9he.jar')
        xquery = File.join(File.dirname(__FILE__), 'marc2bibframe', 'xbin', 'saxon.xqy')

        `java -cp #{saxon} net.sf.saxon.Query  #{xquery} marcxmluri=#{marcxml_file} baseuri=#{baseuri} > #{rdfxml_file}`

        # command = "java -cp #{saxon} net.sf.saxon.Query  #{xquery} marcxmluri=#{marcxml_file} baseuri=#{baseuri} > #{rdfxml_file}"

        rdfxml = ""
        File.open(rdfxml_file, 'r') do |file|
          file.each_line {|line| rdfxml << line }
        end

        # Delete temporary files
        File.delete(marcxml_file,rdfxml_file)

        rdfxml
      end
    end
  end
end


