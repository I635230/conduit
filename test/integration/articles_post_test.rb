require "test_helper"

class ArticlesPostTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "ログインせずにeditorページにアクセスすると、login_urlにリダイレクトされる" do
    get editor_path
    assert_redirected_to login_url
  end

  test "invalidな情報でpostできない" do # TODO: 先にログインのテストヘルパーを作成
    # assert_template 'article/new'
    # assert_no_difference 'Article.count' do
    #   post article_path, params: { article: { title: "", slug: "", content: ""} }
    # end
    # assert_template 'article/new'
  end

  test "validな情報でpostできる" do
  end
end
