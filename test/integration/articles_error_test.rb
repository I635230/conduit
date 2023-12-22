require "test_helper"

class ArticlesErrorTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "titleがエラーでslugもエラーのとき" do
    log_in_as(@user)
    post articles_path, params: { article: { title: "?", description: "description", content: "content" } }
    assert_template 'articles/new'
    @article = assigns(:article)
    error_pul = "error".pluralize(@article.errors.count)
    assert_select 'div.alert-danger', text: "The form contains #{@article.errors.count} #{error_pul}."
    assert_select 'li', text: 'Title is invalid'
    assert_select 'li', text: 'Slug is invalid', count: 0 # slugのエラーメッセージは表示されない
  end

  test "titleがエラーでslugはエラーでないとき" do
    log_in_as(@user)
    @article = @user.articles.create(title: 'title dayo', slug: 'title-dayo', description: 'description', content: 'content')
    patch article_path(@article.slug), params: { article: { title: "?", description: "description", content: "content" } }
    @article = assigns(:article)
    error_pul = "error".pluralize(@article.errors.count)
    assert_select 'div.alert-danger', text: "The form contains #{@article.errors.count} #{error_pul}."
    assert_select 'li', text: 'Title is invalid'
    assert_select 'li', text: 'Slug is invalid', count: 0 # slugのエラーメッセージは表示されない
  end
end
