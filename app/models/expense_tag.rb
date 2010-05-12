class ExpenseTag < ActiveRecord::Base
  validates_presence_of :name
  validate :no_space_in_tag
  has_and_belongs_to_many :expense_item

private

  def no_space_in_tag
    if name && name.index(/\s+/)
      errors.add(:name, '标签里不能有空格')
    end
  end
end
