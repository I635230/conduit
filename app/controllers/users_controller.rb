class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(username: params[:username])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      redirect_to profile_url(@user.username)
    else
      render "new", status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
