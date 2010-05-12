class AddExpensetypeForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE expense_items
        ADD CONSTRAINT expense_type_foreign_key 
        FOREIGN KEY (expense_type_id)
        REFERENCES expense_types(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE expense_items 
        DROP FOREIGN KEY expense_type_foreign_key
    }
  end
end
