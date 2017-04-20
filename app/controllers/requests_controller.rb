class RequestsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show, :update]
  before_action :authenticate_user,   only: :destroy
  before_action :authenticate_post_author, only: :update
  before_action :authenticate_volunteer, only: [:create, :mycommitments]

  def show
    @request = Request.find(params[:id])
    redirect_to root_url and return unless true
  end
  
  def new
    @request = request.new
    @user = @request.user
  end
  
  def create
    if current_user.requests.find_by(post_id: params[:id]).nil?
      @request = current_user.requests.build(request_params)
      if @request.save
        flash[:success] = "request created!"
        redirect_to @request.post
      else
        redirect_to root_url
      end
    else
        flash.now[:error] = "You have already requested to help."
    end
  end

  def destroy
    if current_user.requests.find_by(id: params[:id]).nil?
      @request.user.send_request_decline_email(@request)
    end
    @request.destroy
    flash[:success] = "Request deleted"
    redirect_to request.referrer || root_url
  end
  
  def update
    @request.user.send_request_accept_email(@request)
    @request = Request.find(params[:id])
    @request.status = "accepted"
    @request.save
    flash[:success] = "Request accepted"
    redirect_to request.referrer || root_url
  end
  
  def mycommitments
    @pendingCommitments = current_user.request_feed.where("status == ?", "pending").paginate(page: params[:page])
    @acceptedCommitments = current_user.request_feed.where("status == ?", "accepted").paginate(page: params[:page])
  end

  private

    def request_params
      params.require(:request).permit(:message, :post_id)
    end
    
    def authenticate_post_author
      @privilegeCheck = current_user.user_group.edit_posts?
      @request = Request.find(params[:id])
      redirect_to root_url if @request.post.user_id != current_user.id && @privilegeCheck == false
    end
    
    def authenticate_user
      @curentUserRequest = current_user.requests.find_by(id: params[:id])
      @privilegeCheck = current_user.user_group.edit_posts?
      @request = Request.find(params[:id])
      if @currentUserRequest.nil? && @privilegeCheck == false && @request.post.user_id != current_user.id
        redirect_to(root_url)
      end
    end
    
    def authenticate_volunteer
      @privilegeCheck = current_user.user_group.edit_posts?
      if current_user.account_type != "volunteer" && @privilegeCheck == false
        redirect_to(root_url)
      end
    end
end