class Link < ActiveRecord::Base
  class Show < Trailblazer::Operation
    attr_reader :model

    def process(params)
      token = /^([#{Link::Create::CHARSET.join}]*).*/.match(params[:id])[1]
      @model = Link.find_by_unique_key(token)
      return invalid! unless @model

      @model.url = URLCleaner.new(@model.url).call
      run_analytics(params)
      self
    end

    def self.model_class
      Link
    end

    def run_analytics(params)
      return if params[:user_agent] =~ /Slackbot-LinkExpanding/

      @model.increment!(:use_count)
    end
  end
end
