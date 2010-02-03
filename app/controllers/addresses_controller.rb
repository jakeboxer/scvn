class AddressesController < ApplicationController
  before_filter :get_address, :only => [:show, :edit, :update, :goto]

  # GET /addresses/1
  # GET /addresses/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @address }
    end
  end

  # GET /addresses/new
  # GET /addresses/new.xml
  def new
    @address = Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @address }
    end
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.xml
  def create
    @address = Address.new(params[:address])

    respond_to do |format|
      if @address.save
        flash[:notice] = 'Address was successfully created.'
        format.html { redirect_to @address }
        format.xml do
          render :xml => @address, :status => :created, :location => @address
        end
      else
        format.html { render :action => "new" }
        format.xml do
          render :xml => @address.errors, :status => :unprocessable_entity
        end
      end
    end
  end

  # PUT /addresses/1
  # PUT /addresses/1.xml
  def update
    respond_to do |format|
      if @address.update_attributes(params[:address])
        flash[:notice] = 'Address was successfully updated.'
        format.html { redirect_to @address }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml do
          render :xml => @address.errors, :status => :unprocessable_entity
        end
      end
    end
  end
  
  # GET /addresses/1/goto
  def goto
    redirect_to @address.url
  end
  
  private
  
  def get_address
    @address = Address.find_by_shortened(params[:id])
  end
end
