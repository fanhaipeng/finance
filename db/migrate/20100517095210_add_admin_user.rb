class AddAdminUser < ActiveRecord::Migration
  def self.up
    user = User.new( :nickname => 'Admin',
                     :email => 'fanhaipeng@gmail.com',
                     :password => 'finance@1234',
                     :password_confirmation => 'finance@1234',
                     :role => 0)
    user.save!
  end

  def self.down
    user = User.find_by_email('fanhaipeng@gmail.com')
    User.delete(user)
  end
end
