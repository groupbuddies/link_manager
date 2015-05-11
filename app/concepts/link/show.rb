class Link < ActiveRecord::Base
  class Show < Trailblazer::Operation
    attr_reader :model
    def process(params)
      token = /^([#{Link::Create::CHARSET.join}]*).*/.match(params[:id])[1]
      @model = Link.find_by_unique_key(token)
      return invalid! unless @model

      self
    end
  end
end
