class TagsController < ApplicationController
  def index
    @tags = Tag.all
    
    respond_to do |format|
      format.html
      format.json { render :json => @tags }
    end
  end

  def show
    @tag = Tag.find(params[:id])
  end
  
  def find
    @tag_name = params[:name]
    @tag      = Tag.find_by_name(@tag_name)
    
    respond_to do |format|
      if @tag.nil?
        format.html
      else
        format.html { redirect_to @tag }
      end
    end
  end
  
  def namesearch
    @tags = Tag.all(
      :conditions => ["name LIKE ?", "%#{params[:q]}%"],
      :order      => 'name ASC',
      :limit      => 10,
      :select     => 'name'
    )
    
    # Use no layout, so that it can be accepted by autocomplete
    render :layout => false
  end
end
