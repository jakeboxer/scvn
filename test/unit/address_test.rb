require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "convert between numerical IDs and shortened keys" do
    assert_equal addresses(:scvngr).key, key_to_id(addresses(:scvngr).id)
    assert_equal addresses(:scvngr).id,  id_to_key(addresses(:scvngr).key)
    assert_equal addresses(:jboxer).key, key_to_id(addresses(:jboxer).id)
    assert_equal addresses(:jboxer).id,  id_to_key(addresses(:jboxer).key)
  end
end
