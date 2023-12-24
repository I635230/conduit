require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @article = @user.articles.create(title: "title dayo", slug: "title-dayo", description: "description", content: "content")
  end

  class NoLoginActionTest < ArticlesControllerTest
    test "非ログイン時にnewアクションを実行したときにリダイレクトする" do
      get new_article_path
      assert_redirected_to login_url
    end

    test "非ログイン時にeditアクションを実行したときにリダイレクトする" do
      get edit_article_path(@article.slug)
      assert_redirected_to login_url
    end

    test "非ログイン時にupdateアクションを実行したときにリダイレクトする" do
      patch article_path(@article.slug), params: { article: { title: @article.title,
                                                              description: @article.description,
                                                              content: @article.content } }
      assert_redirected_to login_url
    end

    test "非ログイン時にdestroyアクションを実行したときにリダイレクトする" do
      delete article_path(@article.slug)
      assert_redirected_to login_url
    end
  end

  class OtherUserActionTest < ArticlesControllerTest
    def setup
      super
      @other_user = users(:archer)
      log_in_as(@other_user)
    end

    test "違うユーザーのログイン時にeditアクションを実行したときにリダイレクトする" do
      get edit_article_path(@article.slug)
      assert_redirected_to root_url
    end

    test "違うユーザーのログイン時にupdateアクションを実行したときにリダイレクトする" do
      patch article_path(@article.slug), params: { article: { title: @article.title,
                                                              description: @article.description,
                                                              content: @article.content } }
      assert_redirected_to root_url
    end

    test "違うユーザーのログイン時にdestroyアクションを実行したときにリダイレクトする" do
      delete article_path(@article.slug)
      assert_redirected_to root_url
    end
  end
end
