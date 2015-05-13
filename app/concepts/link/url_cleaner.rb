class Link
  class URLCleaner
    URL_PROTOCOL_HTTP = "http://"
    REGEX_LINK_HAS_PROTOCOL = Regexp.new('\Ahttp:\/\/|\Ahttps:\/\/', Regexp::IGNORECASE)

    def initialize(url)
      @url = url
    end

    def call
      return @url if @url.blank?
      @url = URL_PROTOCOL_HTTP + @url.strip unless @url =~ REGEX_LINK_HAS_PROTOCOL
      URI.parse(@url).normalize.to_s
    end
  end
end
