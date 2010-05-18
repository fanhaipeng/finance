class AddForeignKeyOfUserId < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE expense_items 
        ADD CONSTRAINT eitem_user_foreign_key
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }

    execute %{
      ALTER TABLE expense_types 
        ADD CONSTRAINT etype_user_foreign_key
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }

    execute %{
      ALTER TABLE expense_tags 
        ADD CONSTRAINT etag_user_foreign_key
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE expense_tags DROP FOREIGN KEY etag_user_foreign_key
    }
    execute %{
      ALTER TABLE expense_types DROP FOREIGN KEY etype_user_foreign_key
    }
    execute %{
      ALTER TABLE expense_items DROP FOREIGN KEY eitem_user_foreign_key
    }
  end
end
