class ExpenseItem < ActiveRecord::Base
  # model relationship
  belongs_to :expense_type
  has_and_belongs_to_many :expense_tags

  # validations
  validates_presence_of :date, :expense_type_id, :value
  validates_numericality_of :value, 
                            :greater_than_or_equal_to => 0.01,
                            :message => '金额不能少于一分钱'

  # virtual attribute
  attr_writer :tag_names
  after_save :assign_tags

  def tag_names
    @tag_names || expense_tags.map(&:name).join(' ')
  end

protected

  def assign_tags
    if @tag_names
      self.expense_tags = @tag_names.split(/\s+/).map do |name|
        ExpenseTag.find_or_create_by_name(name)
      end
    end
  end

end
