class Link < ActiveRecord::Base
  class Show < Trailblazer::Operation
    URL_PROTOCOL_HTTP = "http://"
    REGEX_LINK_HAS_PROTOCOL = Regexp.new('\Ahttp:\/\/|\Ahttps:\/\/', Regexp::IGNORECASE)
    attr_reader :model
    def process(params)
      token = /^([#{Link::Create::CHARSET.join}]*).*/.match(params[:id])[1]
      @model = Link.find_by_unique_key(token)
      @model.url = clean_url
      return invalid! unless @model

      self
    end

    private

    def clean_url
      url = @model.url
      return url if url.blank?
      url = URL_PROTOCOL_HTTP + url.strip unless url =~ REGEX_LINK_HAS_PROTOCOL
      URI.parse(url).normalize.to_s
    end
  end
end
