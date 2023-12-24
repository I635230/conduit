require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login_pathにアクセスしたときに正常なステータスコードが返ってくる" do
    get login_path
    assert_response :success
  end
end
