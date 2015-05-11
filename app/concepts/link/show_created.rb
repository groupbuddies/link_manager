class Link < ActiveRecord::Base
  class ShowCreated < Trailblazer::Operation
    attr_reader :model
    def model!(params)
      @model = Link.find(params[:id])
    end
  end
end
