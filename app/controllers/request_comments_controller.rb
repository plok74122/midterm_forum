class RequestCommentsController < ApplicationController
  before_action :set_request

  def new
    @comment = @request.comments.new
  end

  def create
    @comment = @request.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to request_path(@request)
    else
      render :action => "new"
    end
  end

  def destroy
    @comment = @request.comments.find(params[:id])
    @comment.destroy
    redirect_to request_path(@request)
    flash[:alert] = "Delete Successfully!"
  end


  private
  def set_request
    @request = Request.find(params[:request_id])
  end

  def comment_params
    params.require(:comment).permit(:details, :user_id , :request_id )
  end
end
