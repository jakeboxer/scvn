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
  
  test 'block blank URLs' do
    addr = Address.new(:url => '')
    assert !addr.save
  end
  
  test 'block invalid URLs' do
    addr = Address.new(:url => 'scvngr')
    assert !addr.save
  end
  
  test 'addresses have tags' do
    # SCVNGR
    assert addresses(:scvngr).tags.exists?(tags(:tech))
    assert addresses(:scvngr).tags.exists?(tags(:location))
    assert !addresses(:scvngr).tags.exists?(tags(:blog))
    
    # jBoxer
    assert addresses(:jboxer).tags.exists?(tags(:tech))
    assert !addresses(:jboxer).tags.exists?(tags(:location))
    assert addresses(:jboxer).tags.exists?(tags(:blog))
  end
end
