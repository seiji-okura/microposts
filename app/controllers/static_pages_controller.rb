class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      #binding.pry
      @feed_items = current_user.feed_times(params[:page]).includes(:user).order(created_at: :desc)
    end
  end
end
