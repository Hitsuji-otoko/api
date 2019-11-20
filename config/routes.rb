Rails.application.routes.draw do
  get 'access_tokens/create'
  post 'login', to: 'access_tokens#create'
  delete 'logout', to:'access_tokens#destroy'
  resources :articles, only: [:index, :show]
end
