class ArticlesController < ApplicationController
  # devise
  before_action :authenticate_reader!, except: :index

  # custom auth
  # before_action :check_authentication
  # before_action :check_authorization, except: [:show]

  def index
    # authenticate_reader!  
    #   session_id exists?
    #   check the headers...
    #   find the user with the csrf token...

    @articles = Article.all

    @trending_articles = Article.order("RANDOM()")[0..5]

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @articles.json }
    end
  end 

  def show
    @article = Article.find(params[:id])
    @comment = @article.comments.build # Comment.new(article_id: @article.id)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = @current_user.id

    if @article.save
      redirect_to articles_path
    else
      render :new, status: 422
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def article_params
    params.require(:article).permit(:name, :body)
  end

  def check_authorization
    unless @current_user.admin?
      unauthorized
    end
  end
end
