require File.dirname(__FILE__) + '/../test_helper'

class ExpenseItemTest < ActiveSupport::TestCase

  fixtures :expense_types

  def setup
    ExpenseItem.delete_all
  end

  def test_fields_presence
    ei = ExpenseItem.new
    assert !ei.valid?
    assert ei.errors.invalid?(:date)
    assert ei.errors.invalid?(:value)
    assert ei.errors.invalid?(:expense_type_id)
    assert !ei.errors.invalid?(:note)
    assert !ei.errors.invalid?(:tag_names)
  end

  def test_positive_value
    ei = ExpenseItem.new(:date => Date.today,
                                   :note => 'hello')
    ei.expense_type = ExpenseType.find(1)

    ei.value = -1.0                                   
    assert !ei.valid?
    assert_equal "金额不能少于一分钱", ei.errors.on(:value)
    
    ei.value = 0
    assert !ei.valid?
    assert_equal "金额不能少于一分钱", ei.errors.on(:value)

    ei.value = 0.005
    assert !ei.valid?
    assert_equal "金额不能少于一分钱", ei.errors.on(:value)

    ei.value = 0.01 
    assert ei.valid?

    ei.value = 1.0
    assert ei.valid?
  end

  def test_tag_names
    ei = ExpenseItem.new(:date => Date.today,
                         :expense_type_id => 1,
                         :value => 2.0) 
    ei.tag_names = 'tag1 tag2 tag3'

    # test after_save
    assert_equal 0, ei.expense_tags.length
    assert ei.save!
    assert_equal 3, ei.expense_tags.length

    ei1 = ExpenseItem.find(ei.id)
    assert_equal 3, ei1.tag_names.split(/\s+/).length
  end

end
