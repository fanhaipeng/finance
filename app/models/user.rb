class User < ActiveRecord::Base
  validates_presence_of :nickname, :email, :salt, 
                        :password, :password_confirmation
  validates_format_of :email, 
                      :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
                      :message => '电子邮件格式不正确'
  attr_accessor :password_confirmation
  validates_confirmation_of :password,
                            :message => '密码不一致'

  validate :hashed_password_non_blank

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank? 
    create_new_salt
    self.hashed_password = User.encrypt_password(@password, self.salt)
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user
      expected_password = encrypt_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

private
  def hashed_password_non_blank
    errors.add_to_base("密码不能为空") if hashed_password.blank?
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypt_password(password, salt)
    string_to_hash = password + 'finance' + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

end
