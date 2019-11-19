Rails.application.routes.draw do
  get 'access_tokens/create'
  post 'login', to: 'access_tokens#create'
  resources :articles, only: [:index, :show]
end
