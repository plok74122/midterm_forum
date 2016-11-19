class RequestsController < ApplicationController
  before_action :authenticate_user!
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
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      flash[:notice] = "Successfully created!"
      redirect_to requests_path
    else
      @requests = Request.page(params[:page]).per(10)
      render :action => "index"
    end

  end

  private
  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :content)
  end



end
