require File.dirname(__FILE__) + '/../test_helper'

class ExpenseTypesControllerTest < ActionController::TestCase

  fixtures :users
  def setup
    session[:user_id] = users(:one).id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_type" do
    session[:user_id] = users(:one).id
    assert_difference('ExpenseType.count') do
      post :create, :expense_type => { :description => 'expense type A' }
    end

    assert_redirected_to expense_types_url
  end

  test "should show expense_type" do
    get :show, :id => expense_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => expense_types(:one).to_param
    assert_response :success
  end

  test "should update expense_type" do
    put :update, 
        :id => expense_types(:one).to_param, 
        :expense_type => { :description => 'expense type B' }
    assert_redirected_to expense_types_url
    et = ExpenseType.find(expense_types(:one))
    assert_equal 'expense type B', et.description
  end

  test "should destroy expense_type" do
    assert_difference('ExpenseType.count', -1) do
      delete :destroy, :id => expense_types(:one).to_param
    end

    assert_redirected_to expense_types_url
  end
end
