class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :nickname, :null => false
      t.string :email, :null => false
      t.string :salt, :null => false
      t.string :password, :null => false
      t.integer :role, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
