class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
  end
  
  def find
    @tag_name = params[:name]
    @tag      = Tag.find_by_name(@tag_name)
    
    redirect_to @tag unless @tag.nil?
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
