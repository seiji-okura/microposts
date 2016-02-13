class UsersController < ApplicationController
  before_action :set_user,
                only: [:show, :edit, :update, :followings, :followers]
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :authenticate!, only: [:edit, :update]
  
  def show
    if !@user
      flash.now[:danger] = "Could not find the user!"
    end
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    render 'edit'
  end
  
  def update
    if @user.update(user_params)
      session[:user_id] = @user.id
      redirect_to @user, notice: 'ユーザーを編集しました'
    else
      #保存NG
      render 'edit'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :age,
                                 :country, :introduction, :url,
                                 :password, :password_confirmation)
  end
  
  def logged_in_user
    if !logged_in?
      redirect_to login_path
    end
  end
  
  def set_user
    @user = User.find_by(id: params[:id])
  end
  
  def authenticate!
    if @user != current_user
      redirect_to root_url, flash: { alert: "不正なアクセス" }
    end
  end
  
end
