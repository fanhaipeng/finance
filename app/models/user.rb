class User < ActiveRecord::Base
  validates_presence_of :nickname, :email, :salt, 
                        :password, :password_confirmation
  validates_format_of :email, 
                      :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
                      :message => '电子邮件格式不正确'
  attr_accessor :password_confirmation
  validates_confirmation_of :password,
                            :message => '密码不一致'

  validate :password_non_blank

private
  def password_non_blank
    errors.add_to_base("密码不能为空") if password.blank?
  end
end
