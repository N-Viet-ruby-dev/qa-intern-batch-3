class HomeController < ApplicationController
  def index
    @posts = Post.newest.page(params[:page]).per 10
  end
end
