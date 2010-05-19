class ExpenseTag < ActiveRecord::Base
  validates_presence_of :name, :user_id
  validate :no_space_in_tag
  has_and_belongs_to_many :expense_item
  belongs_to :user

  def self.find_by_name_or_create(arg)
    if arg.is_a? String
      find_by_name(arg)
    elsif arg.is_a? Hash
      find_by_name(arg[:name]) || create(arg)
    end
  end

private

  def no_space_in_tag
    if name && name.index(/\s+/)
      errors.add(:name, '标签里不能有空格')
    end
  end
end
