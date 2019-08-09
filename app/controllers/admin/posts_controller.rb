class Admin::PostsController < Admin::BaseController
  before_action :load_post, only: :update

  def index
    @posts = Post.all.order(:id)
    @post = Post.new
    @categories = Category.pluck(:name, :description, :id) || []
    @tags = Tag.pluck(:name) || []
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        check_params_tags
        tag_new = @tag_new.map{|tag| Tag.create! name: tag}
        tag_new.map{|tag| TagPost.create! post_id: @post.id, tag_id: tag.id }
        @tag_available.map{|tag| TagPost.create! post_id: @post.id, tag_id: tag.id}
        format.js { flash[:success] = "Success!!!" }
      else
        format.js
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.js
    end
  end

  def update
    @post.actived = @post.actived? ? false : true
    respond_to do |format|
      if @post.save
        format.js { flash[:success] = "Update success!" }
      else
        format.js { flash[:danger] = "Update failed!" }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :category_id, :title, :content)
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

  def load_post
    return if @post = Post.find_by(id: params[:id])

    flash[:danger] = "Not find"
    redirect_to admin_posts_path
  end
end
