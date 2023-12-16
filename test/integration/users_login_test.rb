require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "invalidな情報ではログインできない" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "user@invalid", 
                                          password: "invalid"} }
    assert_not is_logged_in?
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    # get root_path # まだroot_pathの設定をしていないので、後で
    # assert flash.empty?
  end

  test "validな情報でログインできる & ログアウトできる" do 
    # ログインの確認
    get login_path
    post login_path, params: { session: { email: @user.email, 
                                          password: "password" } }
    assert is_logged_in?
    assert_redirected_to profile_url(@user.username)
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path

    # ログアウトの確認
    delete logout_path
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to login_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
  end
end
