require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create address" do
    assert_difference('Address.count') do
      post :create, :address => { }
    end

    assert_redirected_to address_path(assigns(:address))
  end

  test "should show address" do
    get :show, :key => addresses(:scvngr).key
    assert_response :success
    
    get :show, :id  => addresses(:scvngr).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :key => addresses(:scvngr).key
    assert_response :success
    
    get :edit, :id  => addresses(:scvngr).to_param
    assert_response :success
  end

  test "should update address" do
    put :update, :key => addresses(:scvngr).key, :address => { }
    assert_redirected_to address_path(assigns(:address))
    
    put :update, :id  => addresses(:scvngr).to_param, :address => { }
    assert_redirected_to address_path(assigns(:address))
  end

  test "should destroy address" do
    assert_difference('Address.count', -1) do
      delete :destroy, :key => addresses(:scvngr).key
    end

    assert_redirected_to addresses_path
    
    assert_difference('Address.count', -1) do
      delete :destroy, :id => addresses(:jboxer).to_param
    end

    assert_redirected_to addresses_path
  end
  
  test "should redirect to address's url" do
    get :goto, :key => addresses(:scvngr).key
    assert_redirected_to addresses(:scvngr).url
    
    get :goto, :id => addresses(:scvngr).to_param
    assert_redirected_to addresses(:scvngr).url
  end
end
