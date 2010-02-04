require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create address" do
    assert_difference('Address.count') do
      post :create, :address => { :url => 'http://irrelevant.com' }
    end

    assert_redirected_to assigns(:address)
  end

  test "should show address" do
    get :show, :id  => addresses(:scvngr).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id  => addresses(:scvngr).to_param
    assert_response :success
  end

  test "should update address" do
    put :update, :id  => addresses(:scvngr).to_param,
      :address => { :url => 'http://irrelevant.com' }
    assert_redirected_to assigns(:address)
  end
  
  test "should redirect to address's url" do
    get :goto, :id => addresses(:scvngr).to_param
    assert_redirected_to addresses(:scvngr).url
  end
  
  test "should create address with two new tags" do
    assert_difference 'Tag.count', 2 do
      post :create, :address => { :url => 'http://irrelevant.com',
        :tag_names => 'irrel, evant'}
    end
    
    assert_redirected_to assigns(:address)
  end
  
  test "should create address with weirdly formatted tag names" do
    assert_difference 'Tag.count', 5 do
      post :create, :address => { :url => 'http://irrelevant.com',
        :tag_names => 'irr=l  , 3vant,g<nd>lf,   b\'lr"g   ,kh@z@d-d**m'}
    end
    
    assert_redirected_to assigns(:address)
  end
  
  test "should error on pipe character in tag names" do
    post :create, :address => { :url => 'http://irrelevant.com',
      :tag_names => 'irr, e||evant'}
    
    assert_response :success
    assert !assigns(:address).errors.empty?
  end
  
  test "should error on missing URLs " do
    post :create, :address => {}
    assert_response :success
    assert !assigns(:address).errors.empty?
  end
  
  test "should error on blank URLs " do
    post :create, :address => { :url => '' }
    assert_response :success
    assert !assigns(:address).errors.empty?
  end
  
  test "should error on invalid URLs " do
    post :create, :address => { :url => 'irrelevant' }
    assert_response :success
    assert !assigns(:address).errors.empty?
  end
  
  test "should add a new visit upon hitting a shortened url" do
    assert_difference 'addresses(:scvngr).num_visits', 1 do
      get :goto, :id => addresses(:scvngr).to_param
    end
  end
end
