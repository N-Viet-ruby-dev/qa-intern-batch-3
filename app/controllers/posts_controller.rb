class PostsController < ApplicationController
  before_action :logged_in_user, :check_correct_user, only: %i(new create)

  def new
     @categories = Category.pluck(:name, :description, :id) || []
     @tags = Tag.pluck(:name) || []
  end

  def create
    @post = current_user.posts.build post_params
    begin
      Post.transaction do
        @post.save!
        check_params_tags
        tag_new = @tag_new.map{|tag| Tag.create! name: tag}
        tag_new.map{|tag| TagPost.create! post_id: @post.id, tag_id: tag.id }
        @tag_available.map{|tag| TagPost.create! post_id: @post.id, tag_id: tag.id}
        redirect_to root_path, success: t(:success)
      end
    rescue => e
      flash.now[:danger] = e.message
      render :new
      return
    end
  end

  def show_post_home
    @post = Post.find_by id: params[:post_id]
    @post.update_attribute :view, @post.view + 1
    @comments = @post.comments.newest
  end

  private

  def post_params
    params.require(:post).permit :title, :category_id, :content
  end

  def check_params_tags
    @tag_new = []
    @tag_available = []
    params[:tag].map do |tag|
      if (Tag.find_by name: tag).blank?
        @tag_new << tag
      else
        tag_available = Tag.find_by name: tag
        @tag_available << tag_available
      end
    end
  end
end
