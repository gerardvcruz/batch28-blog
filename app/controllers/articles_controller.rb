class ArticlesController < ApplicationController
  def index
    @articles = Article.all

    @trending_articles = Article.order("RANDOM()")[0..5]

    render json: @articles
    
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
end
