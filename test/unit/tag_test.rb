require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "tags have addresses" do
    # Tech tag
    assert tags(:tech).addresses.exists?(addresses(:scvngr))
    assert tags(:tech).addresses.exists?(addresses(:jboxer))
    
    # Location tag
    assert tags(:location).addresses.exists?(addresses(:scvngr))
    assert !tags(:location).addresses.exists?(addresses(:jboxer))
    
    # Blog tag
    assert !tags(:blog).addresses.exists?(addresses(:scvngr))
    assert tags(:blog).addresses.exists?(addresses(:jboxer))
  end
  
  test "tag names are unique" do
    new_tag = Tag.new(:name => tags(:tech).name)
    assert !new_tag.save
  end
  
  test "tag name uniqueness is case-insensitive" do
    # A fully-lowercased version shouldn't save
    new_tag = Tag.new(:name => tags(:tech).name.downcase)
    assert !new_tag.save
    
    # Neither should a fully-uppercased version
    new_tag = Tag.new(:name => tags(:tech).name.upcase)
    assert !new_tag.save
  end
end
