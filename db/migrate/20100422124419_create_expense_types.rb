class CreateExpenseTypes < ActiveRecord::Migration
  def self.up
    create_table :expense_types do |t|
      t.string :description, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :expense_types
  end
end
