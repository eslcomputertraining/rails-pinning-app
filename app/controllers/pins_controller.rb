class PinsController < ApplicationController
  
  def index
    @pins = Pin.all
  end
  
  def show
    @pin = Pin.find(params[:id])
    @pins = Pin.all 
  end
  
  def show_by_name
    @pin = Pin.find_by_slug(params[:slug])
    @pins = Pin.all
    render :show
  end

end
