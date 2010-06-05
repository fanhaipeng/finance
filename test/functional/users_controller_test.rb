require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase

  fixtures :users

  def setup
    session[:user_id] = users(:one).id
  end

  test "admin should get index" do
    session[:user_id] = users(:admin).id
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get new even not logged in" do
    session[:user_id] = nil
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => {:nickname => 'nick',
                              :email => 'user@example.com',
                              :password => 'pass',
                              :password_confirmation => 'pass' }
    end
    assert_redirected_to user_path(assigns(:user))
  end

  test "should create user even not logged in" do
    session[:user_id] = nil
    assert_difference('User.count') do
      post :create, :user => {:nickname => 'nick',
                              :email => 'user@example.com',
                              :password => 'pass',
                              :password_confirmation => 'pass' }
    end
    assert_redirected_to user_path(assigns(:user))
  end

  test "should go back to new when validation fails" do
    assert_no_difference('User.count') do
      post :create, :user => { :nickname => nil,
                               :email => 'user@example.com',
                               :password => 'pass',
                               :password_confirmation => 'pass' }
    end
    assert_template :new
  end

  test "should show user" do
    get :show, :id => users(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => users(:one).to_param
    assert_response :success
  end

  test "should update user's nickname" do
    put :update, :id => users(:one).to_param, 
        :user => { :nickname => 'nick2', 
                   :password => '', 
                   :password_confirmation => '' },
        :verify => { :oldpass => '' }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should update user's password" do
    put :update, :id => users(:one).to_param, 
        :user => { :nickname => users(:one).nickname,  
                   :password => 'pass2', 
                   :password_confirmation => 'pass2' },
        :verify => { :oldpass => 'pass1' }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should return to edit when nickname is blank" do
    put :update, :id => users(:one).to_param,
        :user => { :nickname => '', 
                   :password => '', 
                   :password_confirmation => ''},
        :verify => { :oldpass => ''}
    assert_template :edit
  end

  test "should return to edit when old pass not passed" do
    put :update, :id => users(:one).to_param,
        :user => { :nickname => users(:one).nickname,
                   :password => 'pass', 
                   :password_confirmation => 'pass' },
        :verify => { :oldpasswd => 'failpass' }
    assert_template :edit
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).to_param
    end
    assert_redirected_to users_path
  end

  test "user(one) should not access user(two)" do
    get :edit, :id => users(:two).to_param
    assert_response 401
    assert_template 'public/401.html'

    put :update, :id => users(:two).to_param,
        :user => { :nickname => users(:two).nickname,
                   :password => 'newpass2', 
                   :password_confirmation => 'newpass2' },
        :verify => { :oldpasswd => 'pass2' }
    assert_response 401
    assert_template 'public/401.html'

    get :show, :id => users(:two).to_param
    assert_response 401
    assert_template 'public/401.html'

    delete :destroy, :id => users(:two).to_param
    assert_response 401
    assert_template 'public/401.html'
  end

  test "admin user can view other users' data" do
    session[:user_id] = users(:admin)
    get :edit, :id => users(:two).to_param
    assert_response :success

    put :update, :id => users(:two).to_param,
        :user => { :nickname => users(:two).nickname,
                   :password => 'newpass2', 
                   :password_confirmation => 'newpass2' },
        :verify => { :oldpasswd => 'pass2' }
    assert_response :success

    get :show, :id => users(:two).to_param
    assert_response :success

    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).to_param
    end
    assert_redirected_to users_path
  end

  test "non-admin user should not view index page" do
    get :index
    assert_response 401
    assert_template 'public/401.html'
  end

end
