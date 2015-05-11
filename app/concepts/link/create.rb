class Link < ActiveRecord::Base
  class Create < Trailblazer::Operation
    UNIQUE_KEY_SIZE = 5
    CHARSET = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
    include CRUD
    model Link, :create

    contract do
      property :url, validates: { presence: true }
      property :unique_key, validates: { uniqueness: true }
    end

    def process(params)
      validate(params[:link]) do |form|
        form.save
      end
    end

    private

    def setup_params!(params)
      unique_key = generate_unique_key
      params[:link].merge!(unique_key: unique_key)
    end

    def generate_unique_key
      (0...UNIQUE_KEY_SIZE).map{ CHARSET[rand(CHARSET.size)] }.join
    end
  end
end