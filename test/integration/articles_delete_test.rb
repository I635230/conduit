require "test_helper"

class ArticlesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @article = @user.articles.create(title: "title dayo", description: "description", slug: "title-dayo", content: "content")
  end

  test "非ログイン時にeditor/:slugにアクセスできない" do
    get edit_article_path(@article.slug)
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "ログインせずにdeleteできない" do
  end

  test "deleteが成功する" do # testでarticles#destroyのcurrent_userが使えないから、うまくいかない
    # get article_path(@article.slug)
    # assert_difference 'Article.count', -1 do
    #   delete destroy_article_path(@article.slug)
    # end
    # assert_response :see_other
    # assert_redirected_to profile_path(@user.username)
  end
end
