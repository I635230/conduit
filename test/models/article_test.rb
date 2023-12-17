require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @article = @user.articles.build(content: "Lorem ipsum", title: "title", slug: "good-example-slug")
  end

  test "適切な値でarticleがvalidになる" do
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

  test "titleが存在しなければinvalid" do
    @article.title = "   "
    assert_not @article.valid?
  end

  test "slugが存在しなければinvalid" do
    @article.slug = "    "
    assert_not @article.valid?
  end

  test "slugがuniqueでなければinvalid" do
    @article_same_slug = @user.articles.build(content: "Lorem ipsum2", title: "title2", slug: "good-example-slug")
    @article.save
    assert_not @article_same_slug.valid?
  end  
  
  test "recentが最初にこなければinvalid" do
    assert_equal articles(:most_recent), Article.first
  end
end
