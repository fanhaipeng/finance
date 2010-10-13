require File.dirname(__FILE__) + '/../test_helper'

class ConfigControllerTest < ActionController::TestCase

  def setup
    session[:user_id] = users(:one).id
  end

  def test_index
    get :index
    assert_response :success

    assert assigns(:expense_types).length >0
    assert assigns(:expense_tags).length >0
    assigns(:expense_types).each{|type| assert_equal(1, type.user_id)}
    assigns(:expense_tags).each{|tag| assert_equal(1, tag.user_id)}
  end

  def test_new_type
    expense_type = { :description => '新标签' }
    assert_difference 'ExpenseType.count' do
      post :new_type,
           :expense_type => expense_type
    end

    assert_redirected_to config_action_url
  end

  def test_admin_user_config_page
    session[:user_id] = users(:admin).id
    get :index
    assert_redirected_to users_path
  end

end
