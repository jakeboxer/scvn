require 'test_helper'

class AddressRoutesTest < ActionController::IntegrationTest
  fixtures :all
  
  test "GET /" do
    # Root should go to the new addresses page
    get '/'
    assert_response :success
    assert_template 'addresses/new'
  end
  
  test "GET /:shortened" do
    assert_difference "addresses(:scvngr).num_visits", 1 do
      get "/#{addresses(:scvngr).shortened}"
    end
    
    assert_redirected_to addresses(:scvngr).url
  end
  
  test "GET /unshortened/addresses/:shortened" do
    get "/unshortened/addresses/#{addresses(:scvngr).shortened}"
    assert_response :success
    assert_template 'addresses/show'
  end
  
  test "GET /unshortened/addresses/:shortened/edit" do
    get "/unshortened/addresses/#{addresses(:scvngr).shortened}/edit"
    assert_response :success
    assert_template 'addresses/edit'
  end
  
  test "PUT /unshortened/addresses/:shortened" do
    put "/unshortened/addresses/#{addresses(:scvngr).shortened}",
      :address => { :url => 'http://www.google.com/' }
    assert_redirected_to addresses(:scvngr)
    addresses(:scvngr).reload
    assert_equal 'http://www.google.com/', addresses(:scvngr).url
  end
  
  test "POST /unshortened/addresses" do
    cond = { :url => 'http://irrelevant.com' }
    assert_difference 'Address.count(:conditions => cond)', 1 do
      post "/unshortened/addresses",
        :address => { :url => 'http://irrelevant.com' }
    end
    
    assert_redirected_to assigns(:address)
  end
end
