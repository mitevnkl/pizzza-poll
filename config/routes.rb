Rails.application.routes.draw do
  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/questions', to: 'pages#create_question'
  post 'create_vote', to: 'pages#create_vote', as: 'create_vote'
  # Defines the root path route ("/")
  # root "articles#index"
end
