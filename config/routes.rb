Rails.application.routes.draw do
  root to: 'links#index'

  resources :links, only: [:create, :show]
  get '/created_link/:id' => 'created_links#show', as: :created_link
  get '/:id' => 'links#show'
end
