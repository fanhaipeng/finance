require File.dirname(__FILE__) + '/../test_helper'

class ExpenseTagsControllerTest < ActionController::TestCase

  fixtures :users

  def setup
    session[:user_id] = users(:one).id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_tag" do
    session[:user_id] = users(:one).id
    assert_difference('ExpenseTag.count') do
      post :create, :expense_tag => { :name => 'Tag'}
    end

    assert_redirected_to expense_tag_path(assigns(:expense_tag))
  end

  test "should show expense_tag" do
    get :show, :id => expense_tags(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => expense_tags(:one).to_param
    assert_response :success
  end

  test "should update expense_tag" do
    put :update, :id => expense_tags(:one).to_param, :expense_tag => { }
    assert_redirected_to expense_tag_path(assigns(:expense_tag))
  end

  test "should destroy expense_tag" do
    assert_difference('ExpenseTag.count', -1) do
      delete :destroy, :id => expense_tags(:one).to_param
    end

    assert_redirected_to expense_tags_path
  end
end
