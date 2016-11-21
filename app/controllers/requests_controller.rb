class RequestsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_request, :only => [:show, :edit, :update, :destroy]

  def index
    @requests = Request.page(params[:page]).per(10)
    # 沒有檢查params[:id]是不是current_user所有
    if params[:id]
      @request = current_user.requests.find_by_id(params[:id])
      unless @request
        @request = Request.new
        flash.now[:notice] = "你不能修改他人的資料"
      end
    else
      @request = Request.new
    end
  end

  def show
    # 避免使用縮寫 what's cm?
    # @comments better
    @cm = @request.comments
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user

    if @request.save
      flash[:notice] = "Successfully created!"
      redirect_to requests_path
    else
      @requests = Request.page(params[:page]).per(10)
      render :action => "index"
    end
  end

  def edit
    render :action => "show"
  end

  def update
    if @request.update(request_params)
      flash[:notice] = "Edit Successfully!"
      redirect_to request_path(request_params)
    else
      render :action => "new"
    end
  end

  def destroy
    @request.destroy
    flash[:alert] = "You just kill your request..."
    redirect_to requests_path(:page =>params[:page])
  end

  private
  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :content , :category_id )
  end



end
