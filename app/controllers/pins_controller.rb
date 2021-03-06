class PinsController < ApplicationController
  before_action :require_login, except: [:index, :show, :show_by_name]

  def index
    #if current_user
      @pins = Pin.all
    #else
    #  @pins = Pin.where(user_id: nil)
    #end
  end
  
  # GET /pin/new
  def new
      @pin = Pin.new
  end

  def show
    @pin = Pin.find(params[:id])
    @users = User.joins(:pinnings).where("users.id = ? or pinnings.pin_id = ?", @pin.user_id, @pin.id)
  end
  
  def show_by_name
    @pin = Pin.find_by_slug(params[:slug])
    @users = User.joins(:pinnings).where("users.id = ? or pinnings.pin_id = ?", @pin.user_id, @pin.id)
    render :show
  end


  def create
    @pin = Pin.create(pin_params)
 
    if @pin.valid?
      @pin.save
      redirect_to pin_path(@pin)
    else
      @errors = @pin.errors
      render :new
    end
  end

  def edit
    @pin = Pin.find(params[:id])
    render :edit
  end

  def update
    @pin = Pin.find(params[:id])
    
      if @pin.update_attributes(pin_params)
        redirect_to pin_path(@pin)
      else
        @errors = @pin.errors
        render :edit
      end
  end

  def repin
    @pin = Pin.find(params[:id])
    @pin.pinnings.create(user: current_user)
    @pinning = @pin.pinnings.where("user_id=?", current_user)
    redirect_to user_path(current_user)
  end
  
  private
 
  def pin_params
    params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :user_id)
  end
  
end
