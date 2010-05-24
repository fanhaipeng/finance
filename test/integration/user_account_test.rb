require File.dirname(__FILE__) + '/../test_helper'

class CreateAccountTest < ActionController::IntegrationTest
 
  def test_create_account
    User.delete_all

    get '/expense'
    assert_redirected_to :controller => :account,
                         :action => :login

    get '/users/new'
    assert_response :success

    assert !session[:user_id]

    assert_difference('User.count') do
      post '/users/create', :user => {:nickname => 'nick',
                                     :email => 'user1@example.com',
                                     :password => 'pass1',
                                     :password_confirmation => 'pass1'}
    end
    assert_redirected_to user_path(assigns(:user))

    user_id = assigns(:user).id.to_s
    get_via_redirect '/users/' + user_id
    assert_response :success
    assert_template 'users/show.html.erb'
  end
end
