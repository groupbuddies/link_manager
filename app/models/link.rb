class Link < ActiveRecord::Base
  URL_PROTOCOL_HTTP = "http://"
  REGEX_LINK_HAS_PROTOCOL = Regexp.new('\Ahttp:\/\/|\Ahttps:\/\/', Regexp::IGNORECASE)

  belongs_to :owner, :polymorphic => true

  # ensure the url starts with it protocol and is normalized
  def self.clean_url(url)
    return nil if url.blank?
    url = URL_PROTOCOL_HTTP + url.strip unless url =~ REGEX_LINK_HAS_PROTOCOL
    URI.parse(url).normalize.to_s
  end

  # generate a shortened link from a url
  # link to a user if one specified
  # throw an exception if anything goes wrong
  def self.generate!(orig_url, owner=nil)
    # if we get a shortened_url object with a different owner, generate
    # new one for the new owner. Otherwise return same object
    if orig_url.is_a?(Shortener::ShortenedUrl)
      return orig_url.owner == owner ? orig_url : generate!(orig_url.url, owner)
    end

    # don't want to generate the link if it has already been generated
    # so check the datastore
    cleaned_url = clean_url(orig_url)
    scope = owner ? owner.shortened_urls : self
    scope.where(:url => cleaned_url).first_or_create
  end

  # return shortened url on success, nil on failure
  def self.generate(orig_url, owner=nil)
    begin
      generate!(orig_url, owner)
    rescue
      nil
    end
  end

  private

  # we'll rely on the DB to make sure the unique key is really unique.
  # if it isn't unique, the unique index will catch this and raise an error
  def create_record
    count = 0
    begin
      self.unique_key = generate_unique_key
      super()
    rescue ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid
      if (count +=1) < 5
        logger.info("retrying with different unique key")
        retry
      else
        logger.info("too many retries, giving up")
        raise
      end
    end
  end
end
