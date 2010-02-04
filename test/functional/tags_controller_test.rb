require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert !assigns(:tags).empty?
  end
  
  test "should show tag" do
    get :show, :id => tags(:tech).to_param
    assert_response :success
    assert_equal    tags(:tech), assigns(:tag)
  end
  
  test "should find tags" do
    get :namesearch, :q => 'g'
    assert_response :success
    assert !assigns(:tags).empty?
  end
end
