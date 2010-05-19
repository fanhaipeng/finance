require File.dirname(__FILE__) + '/../test_helper'

class ExpenseControllerTest < ActionController::TestCase

  fixtures :expense_items

  def test_index
    session[:user_id] = users(:one).id
    get :index
    assert_response :success
    assert assigns(:expense_items)
    assert assigns(:previous_month)
    assert assigns(:next_month)
  end 

  def test_batch_new
    session[:user_id] = users(:one).id
    get :batch_new
    assert_response :success
  end

  def test_batch_create
    date_from = Date.today - 1
    date_to = Date.today + 1
    session[:user_id] = users(:one).id
    assert_difference 'ExpenseItem.count', 3 do
      post :batch_create, 
           :expense_items => mock_expense_items(date_from, date_to)
    end

    assert_redirected_to expense_month_path(date_from.year, date_from.mon)
  end

  def test_batch_create_date
    # date_from equals with date_to
    date_from = Date.today
    date_to = Date.today
    session[:user_id] = users(:one).id
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

  def mock_expense_items date_from, date_to
    { :"date_from(1i)" => date_from.year.to_s,
      :"date_from(2i)" => date_from.mon.to_s,
      :"date_from(3i)" => date_from.day.to_s,
      :"date_to(1i)" => date_to.year.to_s,
      :"date_to(2i)" => date_to.mon.to_s,
      :"date_to(3i)" => date_to.day.to_s,
      :expense_type_id => 2,
      :value => 10.1,
      :note => 'batch create expense items',
      :tag_names => 'batchtag1 batchtag2' }
  end
end
