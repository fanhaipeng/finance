require File.dirname(__FILE__) + '/../test_helper'

class ExpenseTagTest < ActiveSupport::TestCase
  
  def test_fields_presence
    t = ExpenseTag.new
    assert !t.valid?
    assert t.errors.invalid?(:name)
    assert t.errors.invalid?(:user_id)
  end

  def test_space_in_tag
    t = ExpenseTag.new(:name => 'spance in tag')
    assert !t.valid?
    assert t.errors.invalid?(:name)
    assert_equal '标签里不能有空格', t.errors.on(:name)
  end

end
