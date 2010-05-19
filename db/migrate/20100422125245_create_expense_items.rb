class CreateExpenseItems < ActiveRecord::Migration
  def self.up
    create_table :expense_items do |t|
      t.date :date, :null => false
      t.integer :expense_type_id, :null => false
      t.float :value, :null => false
      t.text :note 

      t.timestamps
    end
  end

  def self.down
    drop_table :expense_items
  end
end
