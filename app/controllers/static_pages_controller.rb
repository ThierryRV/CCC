# encoding: UTF-8
#
class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end

    @next_dates = Programmation.next_10_dates()

  end

  def help
  end

  def about
  end

  def contact
  end
end
