require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "Example User", email: "user@example.com", 
                     password: "foobar", password_confirmation: "foobar")
  end

  ###############################################

  class UserCommonTest < UserTest
    test "適切な値でuserがvalidになる" do
      assert @user.valid?
    end

    test "userをdestroyすると、articleもdestroyされる" do
      @user.save
      @user.articles.create!(content: "Lorem ipsum")
      assert_difference 'Article.count', -1 do
        @user.destroy
      end
    end  
  end

  ###############################################

  class UserNameTest < UserTest
    test "nameが存在しないとuserがinvalidになる" do
      @user.username = "   "
      assert_not @user.valid?
    end  

    test "nameの長さが長すぎるとuserがinvalidになる" do
      @user.username = "a" * 5111
      assert_not @user.valid?
    end
  end

  ###############################################

  class UserEmailTest < UserTest
    test "emailが存在しないとuserがinvalidになる" do
      @user.email = "      "
      assert_not @user.valid?
    end

    test "emailの長さが長すぎると、userがinvalidになる" do
      @user.email = "a" * 244 + "@example.com"
      assert_not @user.valid?
    end

    test "emailのフォーマットが間違っていると、userがinvalidになる" do
      invalid_addresses = %w[user@example,com # ドットの代わりにカンマを使用
                             user_at_foo.org # アットマークがない
                             user.name@example.foo@bar_baz.com # アットマークが2つ
                             foo@bar+baz.com # ドメイン名にプラスが入っている
                             user@example..com # ドットが2つ連続している
                             ]

      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        assert_not @user.valid?, "#{invalid_address.inspect}のフォーマットエラーを検知できていません。"
      end
    end

    test "同じemailが存在すると、userはinvalidになる" do
      duplicate_user = @user.dup
      @user.save
      assert_not duplicate_user.valid?
    end

    test "emailがlowercaseとして保存されているか" do
      mixed_case_email = "Foo@ExamPLe.CoM"
      @user.email = mixed_case_email
      @user.save
      assert_equal mixed_case_email.downcase, @user.reload.email
    end
  end

  ###############################################

  class UserPasswordTest < UserTest
    test "passwordが存在しないと、userがinvalidになる" do
      @user.password = @user.password_confirmation = " " * 6
      assert_not @user.valid?
    end

    test "passwordが短すぎると、userがinvalidになる" do
      @user.password = @user.password_confirmation = "a" * 5
      assert_not @user.valid?
    end
  end
end
