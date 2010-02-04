class TagsController < ApplicationController
  
  # GET /unshortened/tags/1
  def show
    @tag = Tag.find(params[:id])
  end
  
  # Search for a tag by name. Redirects to tag's show view if found, shows `not
  # found` page if not.
  # GET /unshortened/tags/find?name=xyz
  def find
    @tag_name = params[:name]
    @tag      = Tag.find_by_name(@tag_name)
    
    redirect_to @tag unless @tag.nil?
  end
  
  # Search for all tag names containing the specified substring. Returns a
  # newline-separated list of (in alphabetical order) the names of the first ten
  # matching tags found.
  # This is really only intended to service the autocomplete box. There's no
  # security risk letting others play with it, but it's pretty unusable for
  # humans.
  # GET /unshortened/tags/namesearch?q=xyz
  def namesearch
    @tags = Tag.all(
      :conditions => ["name LIKE ?", "%#{params[:q]}%"],
      :order      => 'name ASC',
      :limit      => 10,
      :select     => 'name' # We don't need anything besides the name
    )
    
    # Use no layout, so that it can be accepted by autocomplete
    render :layout => false
  end
end
