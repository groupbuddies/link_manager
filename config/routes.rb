Rails.application.routes.draw do
  root to: 'sessions#new'

  get '/auth/headquarters/callback' => 'sessions#create_from_omniauth', as: :headquarters_callback
  delete '/sign_out' => 'sessions#destroy', as: :sign_out

  resources :links, only: [:create, :show, :index]
  get '/:id' => 'links#show'
end
