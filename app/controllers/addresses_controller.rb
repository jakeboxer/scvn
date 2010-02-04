class AddressesController < ApplicationController
  before_filter :get_address, :only => [:show, :edit, :update, :goto]

  # GET /unshortened/addresses/xyz
  def show
  end

  # GET /unshortened/addresses/new
  def new
    @address = Address.new
  end

  # GET /unshortened/addresses/xyz/edit
  def edit
  end

  # POST /unshortened/addresses
  def create
    @address = Address.new(params[:address])
    
    if @address.save
      flash[:notice] = 'Address was successfully created.'
      redirect_to @address
    else
      render :action => :new
    end
  end

  # PUT /unshortened/addresses/xyz
  def update
    if @address.update_attributes(params[:address])
      flash[:notice] = 'Address was successfully updated.'
      redirect_to @address
    else
      render :action => "edit"
    end
  end
  
  # Redirects to the address's URL and records a visitor
  # GET /unshortened/addresses/xyz/goto
  # GET /xyz
  def goto
    @address.visits.create
    redirect_to @address.url
  end
  
  private
  
  def get_address
    @address = Address.find_by_shortened(params[:id])
  end
end
