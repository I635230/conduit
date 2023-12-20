require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @article = @user.articles.create(title: "title dayo", slug: "title-dayo", description: "description", content: "content")
  end

  test "非ログイン時にnewアクションを実行したときにリダイレクトする" do
    get new_article_path
    assert_redirected_to login_url
  end

  test "非ログイン時にeditアクションを実行したときにリダイレクトする" do
    get edit_article_path(@article.slug)
    assert_redirected_to login_url
  end

  test "非ログイン時にupdateアクションを実行したときにリダイレクトする" do
  end
end