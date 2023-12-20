require "test_helper"

class ArticlesPostTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "ログインせずにeditorページにアクセスすると、login_urlにリダイレクトされる" do
    get new_article_path
    assert_redirected_to login_url
  end

  test "ログインせずにpostできない" do
  end

  test "invalidな情報でpostできない" do
    log_in_as(@user)
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: "", description: "", content: ""} }
    end
    assert_template 'articles/new'
  end

  test "validな情報でpostできる" do
    log_in_as(@user)
    get new_article_path
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "title", description: "description", content: "content"} }
    end
    assert_redirected_to profile_url(@user.username)
    follow_redirect!
  end
end
