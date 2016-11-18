class RequestsController < ApplicationController
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

  

  private
  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :content)
  end



end
