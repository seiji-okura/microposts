class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_times = @user.feed_times.includes(:user).order(created_at: :desc)
    end
  end
end
