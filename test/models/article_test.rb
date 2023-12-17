require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @article = @user.articles.build(content: "Lorem ipsum")
  end

  test "valid" do
    assert @article.valid?
  end

  test "user_idが存在しなければinvalid" do
    @article.user_id = nil
    assert_not @article.valid?
  end

  test "contentが存在しなければinvalid" do
    @article.content = "    "
    assert_not @article.valid?
  end

  test "recentが最初にこなければinvalid" do
    assert_equal articles(:most_recent), Article.first
  end
end
