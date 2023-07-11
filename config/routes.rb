Rails.application.routes.draw do
  # root 'articles#index'

  resources :posts

  # resources :articles do
  #   resources :comments
  # end 

  # localhost:3000/auth
  post '/auth/signup' => 'auth#signup'
  post '/auth/signin' => 'auth#signin'

  # localhost:3000/articles
  get '/articles' => 'articles#index', defaults: { format: 'json' }
  get '/articles/new' => 'articles#new', as: 'new_article' # => new_article_path
  get '/articles/:id' => 'articles#show', as: 'article'
  # localhost:3000/articles/new
  post '/articles' => 'articles#create', as: 'create_article' # => create_article_path
end
