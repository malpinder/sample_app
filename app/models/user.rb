# == Schema Information
# Schema version: 20101030202716
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'digest'    # for password encryption via SHA2

class User < ActiveRecord::Base
  attr_accessor :password   # virtual attribute - that means: no database column
  attr_accessible :name, :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # check if password is secure enough
#  def password_secure?
#    password.length > 7
#  end

  validates :name,  :presence => true,
                    :length   => { :within => 3..30 }
  validates :email,   :presence   => true,
                      :format     => { :with => email_regex },
                      :uniqueness => { :case_sensitive => false }   # uniqueness => true , and ignoring the case
  validates :password,  :presence     => true,
                        :length       => { :within => 6..64 },
                        :confirmation => true   #  ,
                        #:if           => :password_secure?

  before_save :encrypt_password

  # CLASS Method defined through "self."authenticate
  def self.authenticate(email, submitted_password)
    user = User.find_by_email(email)
    (user && user.matching_password?(submitted_password)) ? user : nil
#    if user.nil?
#      return nil
#    elsif user.matching_password?(submitted_password)
#      return user
#    else
#      return nil
#    end
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = User.find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def matching_password?(submitted_password)
    encrypt(submitted_password) == self.encrypted_password
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{self.salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end

