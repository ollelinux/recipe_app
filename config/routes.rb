Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'pages/home', to: 'pages#home'
  
  #resources :recepies
  get '/recipes', to: 'recipes#index'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'
end
