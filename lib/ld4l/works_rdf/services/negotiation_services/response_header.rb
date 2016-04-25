module LD4L
  module WorksRDF
    class ResponseHeader

      def self.get_content_type( header )
        parsed_header = self.parse(header)
        content_type = parsed_header["Content-Type"]
        content_type = content_type[0]  if content_type && content_type.kind_of?(Array) && content_type.size > 0
        content_type
      end

      def self.get_status( header )
        parsed_header = self.parse(header)
        parsed_header["Status"]
      end

      # "HTTP/1.1 400 Bad Request\r\n
      # Date: Sat, 22 Aug 2015 18:49:49 GMT\r\n
      # Last-Modified: Sat, 22 Aug 2015 18:49:49 GMT\r\n
      # ETag: \"14f56bed06e\"\r\n
      # Cache-Control: no-cache, no-store\r\n
      # Pragma: no-cache\r\n
      # Expires: Sat, 01 Jan 2000 01:00:00 GMT\r\n
      # Content-Type: application/xml;charset=UTF-8\r\n
      # Connection: close\r\n\r\n"

      def self.parse(header)
        parts_hash = {}
        parts_array = header.split("\r\n")
        parts_array.each do |p|
          match_data = p.match("(.*): (.*)")
          value = nil
          field = "Status"        if p.start_with? "HTTP/1.1"
          value = p[9..11]        if p.start_with? "HTTP/1.1"
          field = match_data[1]   if match_data && match_data.size > 1
          value = match_data[2]   if match_data && match_data.size > 2
          semicolon_split = value.split(";")  if value
          comma_split     = value.split(",")  if value
          if semicolon_split && semicolon_split.size > 1
            value = semicolon_split.collect { |v| v.strip }
          elsif comma_split && comma_split.size > 1
            value = comma_split.collect { |v| v.strip }
          end
          parts_hash[field] = value  if value
        end
        parts_hash
      end

    end
  end
end
