require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
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
    get :show, :id  => addresses(:scvngr).shortened
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id  => addresses(:scvngr).shortened
    assert_response :success
  end

  test "should update address" do
    put :update, :id  => addresses(:scvngr).shortened, :address => { }
    assert_redirected_to address_path(assigns(:address))
  end

  test "should destroy address" do
    assert_difference('Address.count', -1) do
      delete :destroy, :id => addresses(:scvngr).shortened
    end

    assert_redirected_to addresses_path
  end
  
  test "should redirect to address's url" do
    get :goto, :id => addresses(:scvngr).shortened
    assert_redirected_to addresses(:scvngr).url
  end
end
