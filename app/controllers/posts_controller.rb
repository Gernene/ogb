class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show]
  before_action :authenticate_user,   only: :destroy

  def show
    @post = Post.find(params[:id])
    @newRequest  = current_user.requests.build
    @newRequest.post_id = @post.id
    @requests = @post.feed.where("status != ?", "accepted").paginate(page: params[:page])
    @acceptedrequests = @post.feed.where("status == ?", "accepted")
  end
  
  def new
    @post = Post.new
    @user = @post.user
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  
  def search
    @feed_items = Post.all
    if params[:search]
      @feed_items = Post.search(params[:search]).order("created_at DESC").paginate(page: params[:page])
    else
      @feed_items = @feed_items.paginate(page: params[:page])
    end
  end
  
  def myposts
    @feed_items = Post.all.where("user_id == ?", current_user.id).paginate(page: params[:page])
  end

  private

    def post_params
      params.require(:post).permit(:description, :title)
    end
    
    def authenticate_user
      @currentUserPost = current_user.posts.find_by(id: params[:id])
      @privilegeCheck = current_user.user_group.edit_posts?
      if @currentUserPost.nil? && @privilegeCheck == false
        redirect_to(root_url)
      end
    end
end