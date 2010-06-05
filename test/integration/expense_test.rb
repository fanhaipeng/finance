require File.dirname(__FILE__) + '/../test_helper'

class ExpenseeTest < ActionController::IntegrationTest

  fixtures :users

  def test_batch_create
    # login
    get '/account/login'
    assert_response :success
    assert_title '登录'

    post '/account/login', :user => {:username => 'user1@example.com',
                                     :password => 'pass1'}
    assert_redirected_to expense_month_path(Date.today.year, Date.today.mon)
    assert session[:user_id]
    
    # view index page
    get '/expense'
    assert_response :success
    assert_title "#{Date.today.year}年#{Date.today.mon}月花销记录"

    # view batch new page
    get '/expense/batch_new'
    assert_response :success
    assert_title '批量创建花销记录'
    
    # submit batch creat data with error
    date_from = Date.today
    date_to = Date.today + 1
    expense_items = mock_expense_items date_from, date_to
    expense_items[:value] = nil
    assert_no_difference 'ExpenseItem.count' do
      post '/expense/batch_create', :expense_items => expense_items
    end
    assert_template "expense/batch_new.html.erb"
    assert flash[:notice]

    # view batch new page again with error messages
    get '/expense/batch_new'
    assert_response :success
    assert_title '批量创建花销记录'

    # submit batch create data correctly
    expense_items = mock_expense_items date_from, date_to
    assert_difference 'ExpenseItem.count', 2 do
      post '/expense/batch_create', :expense_items => expense_items
    end
    assert_redirected_to "/expense/#{date_from.year}/#{date_from.mon}"
    assert !flash[:notice]

    # redirect back to index page
    get '/expense'
    assert_response :success

  end

private

  def assert_title(title)
    assert_equal(title, assigns(:page_title))
  end
end
