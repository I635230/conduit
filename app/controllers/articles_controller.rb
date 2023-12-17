class ArticlesController < ApplicationController
  def index
    @articles = Article.paginate(page: params[:page])
  end

  def show
    @article = Article.find_by(title: params[:title])
  end
end
