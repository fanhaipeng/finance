require File.dirname(__FILE__) + '/../test_helper'
require 'config/routes.rb'

class RoutingTest < ActionController::TestCase

  def test_expense_routings
    assert_routing('/expense',
                   {:controller => 'expense', :action => 'index'})

    assert_routing('/expense/2010/3',
                   { :controller => 'expense', :action => 'index', :year => '2010', :month => '3' })

    assert_recognizes({ :anything => ["unknown", "request"], :controller => 'expense', :action => 'unknown_request' }, '/unknown/request')
  end

  def test_root_url
    assert_recognizes({:controller => 'expense', :action => 'index'}, '/')
  end

end
