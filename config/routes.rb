Rails.application.routes.draw do
  root to: 'links#index'

  get '/auth/headquarters/callback' => 'sessions#create_from_omniauth', as: :headquarters_callback
  delete '/sign_out' => 'sessions#destroy', as: :sign_out

  resources :links, only: [:create, :show]
  get '/created_link/:id' => 'created_links#show', as: :created_link
  get '/:id' => 'links#show'
end
