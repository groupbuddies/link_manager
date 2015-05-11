class Link < ActiveRecord::Base
  class Index < Trailblazer::Operation
    include CRUD
    model Link, :create

    contract do
      property :url, validates: { presence: true }
    end
  end
end
