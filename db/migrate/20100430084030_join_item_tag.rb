class JoinItemTag < ActiveRecord::Migration
  def self.up
    create_table :expense_items_expense_tags, :id => false do |t|
      t.integer :expense_item_id, :null => false
      t.integer :expense_tag_id, :null => false
    end

    add_index :expense_items_expense_tags, [:expense_item_id, :expense_tag_id], { :unique => true, :name => 'index_items_tags'}
    add_index :expense_items_expense_tags, :expense_item_id, { :unique => false, :name => 'index_tags' }
  end

  def self.down
    drop_table :expense_items_expense_tags
  end
end
