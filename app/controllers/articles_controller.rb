class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]


  def index
    @articles = Article.paginate(page: params[:page], per_page: 10)
  end

  def show
    @article = Article.find_by(slug: params[:slug])
  end

  def new
    @article = Article.new
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

  def destroy
    Article.find_by(slug: params[:slug]).destroy
    redirect_to profile_url(current_user.username), status: :see_other
  end

  private

    def article_params
      params.require(:article).permit(:title, :description, :content)
    end

    # beforeフィルタ用

    def correct_user
      @article = Article.find_by(slug: params[:slug])
      @user = @article.user
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end
end
