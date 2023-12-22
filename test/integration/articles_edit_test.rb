require "test_helper"

class ArticlesEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @article = @user.articles.create(title: "title dayo", description: "description", slug: "title-dayo", content: "content")
  end

  test "invalidな情報でedit/updateが失敗する" do
    log_in_as(@user)
    get edit_article_path(@article.slug)
    assert_template 'articles/edit'
    patch article_path(@article.slug), params: { article: { title: "", 
                                                            description: "", 
                                                            content: "" } }
    assert_response :unprocessable_entity
    assert_template 'articles/edit'
  end

  test "validな情報でedit/updateが成功する" do
    log_in_as(@user)
    get edit_article_path(@article.slug)
    assert_template 'articles/edit'
    patch article_path(@article.slug), params: { article: { title: "title desuyo", 
                                                            description: "description desuyo", 
                                                            content: "contet desuyo" } }
    assert_response :see_other
    assert_redirected_to article_url(@article.slug)
  end
end
