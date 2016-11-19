class RequestsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_request, :only => [:show, :edit, :update, :destroy]

  def index
    @requests = Request.page(params[:page]).per(10)
    if params[:id]
      @request = Request.find(params[:id])
    else
      @request = Request.new
    end
  end

  def show
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
