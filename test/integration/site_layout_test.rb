require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @article = @user.articles.create(title: "title dayo", slug: "title-dayo", description: "description", content: "content")
  end

  class CommonLayoutTest < SiteLayoutTest
    # paginationがないページで確認する(1がホームへのリンクなので)

    test "非ログイン時のヘッダーとフッターのリンク" do
      get login_path
      assert_template "sessions/new"
      assert_select "a[href=?]", root_path, count: 3
      assert_select "a[href=?]", login_path
      assert_select "a[href=?]", register_path
    end

    test "ログイン時のヘッダーとフッターのリンク" do
      log_in_as(@user)
      get login_path
      assert_select "a[href=?]", root_path, count: 3
      assert_select "a[href=?]", new_article_path
      assert_select "a[href=?]", profile_path(@user.username)
      assert_select "a[href=?]", logout_path
    end
  end

  class RootLayoutTest < SiteLayoutTest
    test "ホームページのタイトル" do
      get root_path
      assert_template "articles/index"
      assert_select "title", full_title("Home")
    end

    test "ホームページのリンク" do
      get root_path
      Article.paginate(page: 1, per_page: 10).each do |article|
        assert_select "a[href=?]", profile_path(article.user.username)
        assert_select "a[href=?]", article_path(article.slug)
      end
    end
  end

  class UsersShowLayoutTest < SiteLayoutTest
    test "プロフィールページのタイトル" do
      get profile_path(@user.username)
      assert_select "title", full_title(@user.username)
    end

    test "プロフィールページのリンク" do
      get profile_path(@user.username)
      assert_select "nav.pagination"
      @user.articles.paginate(page: 1, per_page: 5).each do |article|
        assert_select "a[href=?]", profile_path(article.user.username)
        assert_select "a[href=?]", article_path(article.slug)
      end
    end
  end

  class ArticleShowLayoutTest < SiteLayoutTest
    test "記事ページのタイトル" do
      get article_path(@article.slug)
      assert_select "title", full_title(@article.title)
    end

    test "非ログイン時の記事ページのリンク" do
      get article_path(@article.slug)
      assert_select "a[href=?]", profile_path(@article.user.username), count: 2
    end

    test "ログイン時の記事ページのリンク" do
      log_in_as(@user)
      get article_path(@article.slug)
      assert_select "a[href=?]", edit_article_path(@article.slug), count: 2 # edit link
      assert_select "a[href=?]", article_path(@article.slug), count: 2 # delete link
    end
  end
end
