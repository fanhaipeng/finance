class AssociateUserId < ActiveRecord::Migration
  def self.up
    add_column :expense_items, :user_id, :integer, :null => false
    add_column :expense_types, :user_id, :integer, :null => false
    add_column :expense_tags, :user_id, :integer, :null => false
  end

  def self.down
    remove_column :expense_tags, :user_id
    remove_column :expense_tags, :user_id
    remove_column :expense_tags, :user_id
  end
end
