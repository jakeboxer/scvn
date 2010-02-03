require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test 'convert between numerical and shortened IDs' do
    scvngr = addresses(:scvngr)
    jboxer = addresses(:jboxer)
    assert_equal scvngr.shortened, Address.id_to_shortened(scvngr.id)
    assert_equal scvngr.id,        Address.shortened_to_id(scvngr.shortened)
    assert_equal jboxer.shortened, Address.id_to_shortened(jboxer.id)
    assert_equal jboxer.id,        Address.shortened_to_id(jboxer.shortened)
  end
  
  test 'find by shortened ID' do
    scvngr = addresses(:scvngr)
    jboxer = addresses(:jboxer)
    assert_equal scvngr, Address.find_by_shortened(scvngr.shortened)
    assert_equal jboxer, Address.find_by_shortened(jboxer.shortened)
  end
end
