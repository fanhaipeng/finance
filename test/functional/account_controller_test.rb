require File.dirname(__FILE__) + '/../test_helper'

class AccountControllerTest < ActionController::TestCase

  fixtures :users

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should has session[:user_id] after logged in" do
    post :login, :user => {:username => 'user1@example.com',
                           :password => 'pass1'}
    assert session[:user_id]
    assert_redirected_to expense_month_path(Date.today.year, Date.today.mon)
  end

  test "should not have session[:user_id] after logged out" do
    session[:user_id] = 1
    post :logout
    assert !session[:user_id]
    assert_redirected_to :controller => :account, :action => :login
  end
end
