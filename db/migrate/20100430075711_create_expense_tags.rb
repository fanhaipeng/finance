class CreateExpenseTags < ActiveRecord::Migration
  def self.up
    create_table :expense_tags do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :expense_tags
  end
end
