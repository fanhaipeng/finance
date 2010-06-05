require File.dirname(__FILE__) + '/../test_helper'

class ExpenseItemsControllerTest < ActionController::TestCase

  fixtures :expense_types
  fixtures :expense_items
  fixtures :users

  def setup
    session[:user_id] = users(:one).id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_items)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_equal('新建花销记录', assigns(:page_title))
    assert assigns(:expense_types)
  end

  test "should create expense_item" do
    assert_difference('ExpenseItem.count') do
      post :create, :expense_item => 
        { :date => Date.today,
          :expense_type_id => 1,
          :value => 3.1,
          :note => 'hello',
          :tag_names => 'tag1 tag2' }
    end

    assert_redirected_to expense_month_path(
      assigns(:expense_item).date.year,
      assigns(:expense_item).date.mon)

  end

  test "should return back to new when validation failed" do
    assert_no_difference('ExpenseItem.count') do
      post :create, :expense_item => 
        { :date => Date.today,
          :expense_type_id => 1,
          :value => 0.00,
          :note => 'hello',
          :tag_names => 'tag1 tag2' }
    end  
    assert_template :new
  end

  test "should show expense_item" do
    get :show, :id => expense_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => expense_items(:one).to_param
    assert_response :success
    assert_equal('更新花销记录', assigns(:page_title))
    assert assigns(:expense_types)
  end

  test "should update expense_item" do
    put :update, 
        :id => expense_items(:one).to_param, 
        :expense_item => { :date => Date.today+1, 
                           :expense_type_id => 2, 
                           :value => 8.8,
                           :note => 'changed to 8.8',
                           :tag_names => 'tag1 tag5' }

    assert_redirected_to expense_month_path(
      assigns(:expense_item).date.year,
      assigns(:expense_item).date.mon)

    ei = ExpenseItem.find(expense_items(:one).to_param)
    assert_equal Date.today+1, ei.date
    assert_equal 2, ei.expense_type_id
    assert_equal 8.8, ei.value
    assert_equal 'changed to 8.8', ei.note
    assert_equal 'tag1 tag5', ei.tag_names
  end

  test "should destroy expense_item" do
    assert_difference('ExpenseItem.count', -1) do
      delete :destroy, :id => expense_items(:one).to_param
    end

    assert_redirected_to expense_month_path(Date.today.year, Date.today.mon)
  end
end
