class Link < ActiveRecord::Base
  class Index < Trailblazer::Operation
    def process(params)
      Link.where(owner_email: params[:user_email]).order(created_at: :desc)
    end
  end
end
