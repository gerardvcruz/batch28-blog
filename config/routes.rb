Rails.application.routes.draw do
  # root 'articles#index'

  resources :posts

  # resources :articles do
  #   resources :comments
  # end 

  # localhost:3000/auth
  get '/auth/current' => 'auth#current'
  post '/auth/signup' => 'auth#signup'
  post '/auth/signin' => 'auth#signin'
  post '/auth/signout' => 'auth#signout'

  # scope :auth do
  #   get '/current' => 'auth#current'
  # end

  # localhost:3000/articles
  get '/articles' => 'articles#index', defaults: { format: 'json' }
  get '/articles/new' => 'articles#new', as: 'new_article' # => new_article_path
  get '/articles/:id' => 'articles#show', as: 'article'
  post '/articles' => 'articles#create', as: 'create_article' # => create_article_path
end
