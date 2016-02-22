class UsersController < ApplicationController
  before_action :set_user,
                only: [:show, :edit, :update, :followings, :followers]
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :authenticate!, only: [:edit, :update]
  before_action :get_num_followings, only: [:show, :followings, :followers]
  before_action :get_num_followers, only: [:show, :followings, :followers]
  
  def followings
    @users = @user.following_users.page(params[:page])
    #binding.pry
  end
  
  def followers
    @users = @user.follower_users.page(params[:page])
    #binding.pry
  end
  
  
  def show
    if !@user
      flash.now[:danger] = "Could not find the user!"
      return
    end
    #@users = folowings
    @num_followings = @user.following_relationships.count
    @num_followers  = @user.follower_relationships.count
    @microposts = @user.microposts.page(params[:page]).order(created_at: :desc)
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
  
  def set_user
    @user = User.find_by(id: params[:id])
  end
  
  def get_num_followers
    @num_followers  = @user.follower_relationships.count
  end
  
  def get_num_followings
    @num_followings = @user.following_relationships.count
  end

  def authenticate!
    if @user != current_user
      redirect_to root_url, flash: { alert: "不正なアクセス" }
    end
  end
  
end
