require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  def test_presence_of_fields
    user = User.new    
    assert !user.valid?
    assert user.errors.invalid?(:nickname)
    assert user.errors.invalid?(:email)
    assert user.errors.invalid?(:salt)
    assert user.errors.invalid?(:password)
  end

  def test_email_format
    user = User.new( :nickname => 'nickname',
                      :salt => 'salt',
                      :password => 'password',
                      :password_confirmation => 'password')
    user.email = 'user'
    assert !user.valid?
    assert_equal '电子邮件格式不正确', user.errors.on(:email)

    user.email = 'user@aaa'
    assert !user.valid?
    assert_equal '电子邮件格式不正确', user.errors.on(:email)

    user.email = 'user@example.com'
    assert_equal 1, user.role
    assert user.valid?
  end

  def test_password_confirmation
    user = User.new( :nickname => 'nickname',
                     :salt => 'salt',
                     :email => 'user@example.com')
    user.password = 'password'
    user.password_confirmation = 'pswd'
    assert !user.valid?
    assert_equal '密码不一致', user.errors.on(:password)

    user.password_confirmation = 'password'
    assert user.valid?

  end

  def test_password_non_blank
  end
end
