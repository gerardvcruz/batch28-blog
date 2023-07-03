Rails.application.routes.draw do
  root 'articles#index'

  # resources :posts

  # localhost:3000/articles
  get '/articles' => 'articles#index'
  get '/articles/new' => 'articles#new', as: 'new_article' # => new_article_path
  get '/articles/:id' => 'articles#show', as: 'show_article'
  # localhost:3000/articles/new
  post '/articles' => 'articles#create', as: 'create_article' # => create_article_path
end
