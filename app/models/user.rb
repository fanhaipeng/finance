class User < ActiveRecord::Base
  validates_presence_of :nickname, :email, :salt, :password
  validates_format_of :email, 
                      :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
                      :message => '电子邮件格式不正确'
end
