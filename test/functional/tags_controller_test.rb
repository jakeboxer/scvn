require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  test "should show tag" do
    get :show, :id => tags(:tech).to_param
    assert_response :success
    assert_equal    tags(:tech), assigns(:tag)
  end
  
  test "should redirect to root on an invalid tag id" do
    get :show, :id => 'irrelevant'
    assert_redirected_to root_path
    assert_equal         "irrelevant isn't a valid tag id.", flash[:warning]
  end
  
  test "should get tag names" do
    get :namesearch, :q => 'g'
    assert_response :success
    assert !assigns(:tags).empty?
  end
  
  test "should find tag" do
    get :find, :name => tags(:tech).name
    assert_redirected_to tags(:tech)
  end
  
  test "shouldn't find tag" do
    get :find, :name => 'irrelevant'
    assert_response :success
  end
end
