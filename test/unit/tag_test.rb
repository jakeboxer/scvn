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
end
