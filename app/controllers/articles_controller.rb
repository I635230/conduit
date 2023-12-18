class ArticlesController < ApplicationController
  def index
    @articles = Article.paginate(page: params[:page], per_page: 10)
  end

  def show
    @article = Article.find_by(slug: params[:slug])
  end

  def new
    @article = Article.new
    if logged_in?
      # render
    else 
      redirect_to login_url, status: :see_other
    end
  end

  def create
    @user = current_user
    @article = @user.articles.build(article_params)
    @article.slug = @article.title.gsub(" ", "-")
    if @article.save
      redirect_to profile_url(@article.user.username)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find_by(slug: params[:slug])
  end

  def update
    @article = Article.find_by(slug: params[:slug])
    if @article.update(article_params)
      redirect_to article_url(@article.slug)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :slug, :description, :content)
    end
end
