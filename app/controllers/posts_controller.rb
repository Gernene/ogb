class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy, :show, :myposts]
  before_action :authenticate_post_author,   only: :destroy
  before_action :authenticate_organization, only: [:new, :create, :myposts]

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
      redirect_to @post
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.requests.destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to(myposts_path)
  end
  
  def search
    @categories = Category.all
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
      params.require(:post).permit(:description, :title, :scheduling, :location)
    end
    
    def authenticate_post_author
      @currentUserPost = current_user.posts.find_by(id: params[:id])
      @privilegeCheck = current_user.user_group.edit_posts?
      if @currentUserPost.nil? && @privilegeCheck == false
        redirect_to(root_url)
      end
    end
    
    def authenticate_organization
      @privilegeCheck = current_user.user_group.edit_posts?
      if current_user.account_type != "organization" && @privilegeCheck == false
        redirect_to(root_url)
      end
    end
end