class PinsController < ApplicationController
  
  def index
    @pins = Pin.all
  end
  
  def show
    @pin = Pin.find(params[:id])
  end
  
  def show_by_name
    @pin = Pin.find_by_slug(params[:slug])
    @pins = Pin.all
    render :show
  end

  RSpec.describe PinsController do
    describe "GET index" do
 
    it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
    end
  
    it 'populates @pins with all pins' do
      get :index
      expect(assigns[:pins]).to eq(Pin.all)

    end
    
  end
end
