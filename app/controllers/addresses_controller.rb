class AddressesController < ApplicationController
  before_filter :get_address, :only => [:show, :edit, :update, :goto]

  # GET /addresses/1
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.xml
  def create
    @address = Address.new(params[:address])
    
    if @address.save
      flash[:notice] = 'Address was successfully created.'
      redirect_to @address
    else
      render :action => :new
    end
  end

  # PUT /addresses/1
  # PUT /addresses/1.xml
  def update
    if @address.update_attributes(params[:address])
      flash[:notice] = 'Address was successfully updated.'
      redirect_to @address
    else
      render :action => "edit"
    end
  end
  
  # GET /addresses/1/goto
  def goto
    @address.visits.create
    redirect_to @address.url
  end
  
  private
  
  def get_address
    @address = Address.find_by_shortened(params[:id])
  end
end
