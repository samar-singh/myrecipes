Rails.application.routes.draw do
root 'pages#home'
get '/home' , to: 'pages#home'
get 'recipes', to: 'recipes#index'
get 'recipes/new', to: 'recipes#new', as: 'new_recipes'
end
