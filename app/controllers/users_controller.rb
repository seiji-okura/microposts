class UsersController < ApplicationController
  
  def show
    @user = current_user
    
    if !logged_in?
      redirect_to login_path
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
    @user = current_user
    
    if logged_in?
      render 'edit'
    else
      redirect_to login_path
    end
  end
  
  def update
    @user = current_user
    
    if logged_in?
      if @user.update(user_params)
        session[:user_id] = @user.id
        redirect_to @user, notice: 'ユーザーを編集しました'
      else
        render 'edit'
      end
    else
      #flash[:danger] = "invalid email/password combination"
      redirect_to login_path
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :age,
                                 :country, :introduction, :url,
                                 :password, :password_confirmation)
                               
  end
  
end
