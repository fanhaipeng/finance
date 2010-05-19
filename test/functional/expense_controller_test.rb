require File.dirname(__FILE__) + '/../test_helper'

class ExpenseControllerTest < ActionController::TestCase

  fixtures :expense_items

  def test_index
    get :index
    assert_response :success
    assert assigns(:expense_items)
    assert assigns(:previous_month)
    assert assigns(:next_month)
  end 

  def test_batch_new
    get :batch_new
    assert_response :success
  end

  def test_batch_create
    date_from = Date.today - 1
    date_to = Date.today + 1
    assert_difference 'ExpenseItem.count', 3 do
      post :batch_create, :expense_items =>
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

    assert_redirected_to expense_month_path((Date.today-1).year, (Date.today-1).mon)
  end

  def test_batch_create_date
    # date_from equals with date_to
    date_from = Date.today
    date_to = Date.today
    assert_difference 'ExpenseItem.count' do
      post :batch_create, :expense_items =>
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
    assert_redirected_to expense_month_path(Date.today.year, Date.today.mon)

    # date_from is greater than date_to
    date_from = Date.today + 1
    date_to = Date.today - 1
    assert_no_difference 'ExpenseItem.count' do
      post :batch_create, :expense_items =>
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
    assert_template :batch_new
    assert flash[:notice]
  end

end
