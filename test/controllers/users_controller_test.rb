require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "register_pathにアクセスしたときに正常なステータスコードが返ってくる" do
    get register_path
    assert_response :success
  end
end
