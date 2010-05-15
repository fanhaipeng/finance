class ExpenseType < ActiveRecord::Base
  validates_presence_of :description
  has_many :expense_items
end