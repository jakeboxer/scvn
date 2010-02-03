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
  
  test 'update tags with normal names' do
    tags = 'irr, el, evant'
    addr = Address.create(:url => 'http://irrelevant.com', :tag_names => tags)
    assert addr.tags.exists?(Tag.find_by_name('irr'))
    assert addr.tags.exists?(Tag.find_by_name('el'))
    assert addr.tags.exists?(Tag.find_by_name('evant'))
    assert !addr.tags.exists?(tags(:blog))
  end
  
  test 'update tags with weird names and whitespace' do
    tags = '1%#  ,  $\',ev@n"   ,,ly'
    addr = Address.create(:url => 'http://irrelevant.com', :tag_names => tags)
    assert addr.tags.exists?(Tag.find_by_name('1%#'))
    assert addr.tags.exists?(Tag.find_by_name('$\''))
    assert addr.tags.exists?(Tag.find_by_name('ev@n"'))
    assert addr.tags.exists?(Tag.find_by_name('ly'))
    assert !addr.tags.exists?(tags(:blog))
  end
end
