class RequestCommentsController < ApplicationController
  before_action :set_request

  def new
    @comment = @request.comments.new
  end

  def create
    @comment = @request.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Create Successfully!"
      redirect_to request_path(@request)
    else
      render :action => "new"
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to request_path(@request)
    flash[:alert] = "Delete Successfully!"
  end


  private
  def set_request
    @request = Request.find(params[:request_id])
  end

  def comment_params
    # 不需要permit request_id & user_id
    # 第十行提供了user_id @request.comments.new 提供了@request_id
    params.require(:comment).permit(:details)
  end
end
