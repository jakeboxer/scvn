require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test 'convert between numerical IDs and shortened keys' do
    scvngr = addresses(:scvngr)
    jboxer = addresses(:jboxer)
    assert_equal scvngr.key, Address.id_to_key(scvngr.id)
    assert_equal scvngr.id,  Address.key_to_id(scvngr.key)
    assert_equal jboxer.key, Address.id_to_key(jboxer.id)
    assert_equal jboxer.id,  Address.key_to_id(jboxer.key)
  end
  
  test 'find by key' do
    scvngr = addresses(:scvngr)
    jboxer = addresses(:jboxer)
    assert_equal scvngr, Address.find_by_key(scvngr.key)
    assert_equal jboxer, Address.find_by_key(jboxer.key)
  end
end
