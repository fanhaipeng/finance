require File.dirname(__FILE__) + '/../test_helper'

class ExpenseControllerTest < ActionController::TestCase

  def setup
    session[:user_id] = users(:one).id
  end

  def test_index
    get :index
    assert_response :success

    assert_select "title", "#{Date.today.year}年#{Date.today.mon}月花销记录"

    assert assigns(:expense_items).length > 0
    assigns(:expense_items).each {|item| assert_equal(1, item.user_id)}

    assert assigns(:previous_month)
    assert assigns(:next_month)
  end 

  def test_batch_new
    get :batch_new
    assert_response :success
    assert_equal('批量创建花销记录', assigns(:page_title))

    assert ExpenseType.find_all_by_user_id(session[:user_id], assigns(:expense_types).length)
  end

  def test_batch_create
    date_from = Date.today - 1
    date_to = Date.today + 1
    assert_difference 'ExpenseItem.count', 3 do
      post :batch_create, 
           :expense_items => mock_expense_items(date_from, date_to)
    end

    assert_redirected_to expense_month_path(date_from.year, date_from.mon)
  end

  def test_batch_create_fail_validate
    date_from = Date.today - 1
    date_to = Date.today + 1
    expense_items = mock_expense_items(date_from, date_to)
    expense_items[:value] = nil
    assert_no_difference 'ExpenseItem.count' do
      post :batch_create, 
           :expense_items => expense_items
    end
    assert_template :batch_new
    assert flash[:notice]
  end

  def test_batch_create_date
    # date_from equals with date_to
    date_from = Date.today
    date_to = Date.today
    assert_difference 'ExpenseItem.count' do
      post :batch_create, :expense_items => mock_expense_items(date_from, date_to)
    end
    assert_redirected_to expense_month_path(date_from.year, date_from.mon)

    # date_from is greater than date_to
    date_from = Date.today + 1
    date_to = Date.today - 1
    assert_no_difference 'ExpenseItem.count' do
      post :batch_create, 
           :expense_items => mock_expense_items(date_from, date_to)
    end
    assert_template :batch_new
    assert flash[:notice]
  end

  def test_login_redirect
    session[:user_id] = nil
    date_from = Date.today - 1
    date_to = Date.today + 1
    action_hash = 
      {'index' => { :method => 'get', 
                    :object => nil,
                    :assert_method => 'assert_response',
                    :assert_result => :success},
       'batch_new' => { :method => 'get', 
                        :object => nil,
                        :assert_method => 'assert_response',
                        :assert_result => :success}, 
       'batch_create' => { :method => 'post', 
                           :object => { :expense_items => mock_expense_items(date_from, date_to)},
                           :assert_method => 'assert_redirected_to',
                           :assert_result => expense_month_path(date_from.year, date_from.mon)}}

    # when user is not logged in, redirect to account/login
    action_hash.each do |action, args| 
      self.send args[:method], action, args[:object]     
      assert_redirected_to :controller => 'account', :action => :login 
    end

    # after user logged in, go to where it should go
    session[:user_id] = users(:one).id
    action_hash.each do |action, args|
      self.send args[:method], action, args[:object]     
      self.send args[:assert_method], args[:assert_result]
    end
  end

  def test_row_color_1
    session[:user_id] = users(:three).id
    get :index
    assert_response :success

    assert_select "tbody tr", :count => 7
    assert_select "tbody tr[class=dataRowOdd]:first-child" 
    assert_select "tbody tr[class=dataRowEven]:nth-child(2)" 
    assert_select "tbody tr[class=dataRowOdd]:nth-child(3)" 
    assert_select "tbody tr[class=dataRowOdd]:nth-child(4)" 
    assert_select "tbody tr[class=dataRowEven]:nth-child(5)" 
    assert_select "tbody tr[class=dataRowEven]:nth-child(6)" 
    assert_select "tbody tr[class=dataRowEven]:nth-child(7)" 
  end

end
