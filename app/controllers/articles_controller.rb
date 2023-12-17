class ArticlesController < ApplicationController
  def index
    @articles = Article.paginate(page: params[:page])
  end

  def show
    @article = Article.find_by(title: params[:title])
  end

  def new
    if logged_in?
      # render
    else 
      redirect_to login_url, status: :see_other
    end
  end

  def create
    @user = current_user
    @article = @user.articles.build(article_params)
    if @article.save
      redirect_to profile_url(@article.user.username)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  private

    def article_params
      params.require(:article).permit(:title, :slug, :content)
    end
end
