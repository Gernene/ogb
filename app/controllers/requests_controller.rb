class RequestsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show, :update]
  before_action :authenticate_user,   only: :destroy
  before_action :post_user, only: :update

  def show
    @request = Request.find(params[:id])
    redirect_to root_url and return unless true
  end
  
  def new
    @request = request.new
    @user = @request.user
  end
  
  def create
    @request = current_user.requests.build(request_params)
    if @request.save
      flash[:success] = "request created!"
    else
      redirect_to root_url
    end
  end

  def destroy
    @request.destroy
    flash[:success] = "request deleted"
    redirect_to request.referrer || root_url
  end
  
  def update
    @request = Request.find(params[:id])
    @request.status = "accepted"
    flash[:success] = "request accepted"
    redirect_to request.referrer || root_url
  end
  
  def commitments
    @pendingCommitments = current_user.requests.where("status == ?", "pending")
    @acceptedCommitments = current_user.requests.where("status == ?", "accepted")
  end

  private

    def request_params
      params.require(:request).permit(:message, :post_id)
    end
    
    def correct_user
      @request = current_user.requests.find_by(id: params[:id])
      redirect_to root_url if @request.nil?
    end
    
    def post_user
      @request = Request.find(params[:id])
      redirect_to root_url if @request.post.user_id != current_user.id
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.user_group.edit_posts?
    end
    
    def authenticate_user
      @curentUserRequest = current_user.requests.find_by(id: params[:id])
      @privilegeCheck = current_user.user_group.edit_posts?
      @request = Request.find(params[:id])
      if @currentUserRequest.nil? && @privilegeCheck == false && @request.post.user_id != current_user.id
        redirect_to(root_url)
      end
    end
end