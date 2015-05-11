class Link < ActiveRecord::Base
  class Index < Trailblazer::Operation
    def process(params)
      Link.all.order(created_at: :desc)
    end
  end
end
