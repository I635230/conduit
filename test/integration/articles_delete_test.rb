require "test_helper"

class ArticlesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @article = @user.articles.create(title: "title dayo", description: "description", slug: "title-dayo", content: "content")
  end

  test "ログインせずにdeleteできない" do
    assert_no_difference "Article.count" do
      delete article_path(@article.slug)
    end
  end

  test "ログインするとdeleteが成功する" do
    log_in_as(@user)
    assert_difference "Article.count", -1 do
      delete article_path(@article.slug)
    end
    assert_response :see_other
    assert_redirected_to profile_url(@article.user.username)
  end
end
