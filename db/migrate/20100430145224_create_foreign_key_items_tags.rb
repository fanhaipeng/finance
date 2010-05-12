class CreateForeignKeyItemsTags < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE expense_items_expense_tags
        ADD CONSTRAINT foreign_key_item_id
        FOREIGN KEY (expense_item_id)
        REFERENCES expense_items(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }

    execute %{
      ALTER TABLE expense_items_expense_tags
        ADD CONSTRAINT foreign_key_tag_id
        FOREIGN KEY (expense_tag_id)
        REFERENCES expense_tags(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE DROP FOREIGN KEY foreign_key_tag_id
    }
    execute %{
      ALTER TABLE DROP FOREIGN KEY foreign_key_item_id
    }
  end
end
