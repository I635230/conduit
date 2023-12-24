require "test_helper"

class UsersRegisterTest < ActionDispatch::IntegrationTest

  test "invalidな情報でregisterすると失敗する" do
    get register_path
    assert_no_difference 'User.count' do
      post register_path, params: { user: { username: "",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar" } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
  end

  test "validな情報でregisterすると成功する" do
    get register_path
    assert_difference 'User.count', 1 do
      post register_path, params: { user: { username: "example",
                                         email: "user@example.com",
                                         password: "foobar",
                                         password_confirmation: "foobar" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
