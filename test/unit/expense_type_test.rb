require File.dirname(__FILE__) + '/../test_helper'

class ExpenseTypeTest < ActiveSupport::TestCase

  def test_fields_presense
    expense_type = ExpenseType.new
    assert !expense_type.valid?
    assert expense_type.errors.invalid?(:description)
  end

end
