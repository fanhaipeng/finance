class ExpenseType < ActiveRecord::Base
  validates_presence_of :description, :user_id
  has_many :expense_items
  belongs_to :user
end
