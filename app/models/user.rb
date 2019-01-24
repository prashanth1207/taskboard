class User < ApplicationRecord
  attr_accessor :password
  validates :email, uniqueness: true
  validates :email, :username, presence: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, confirmation: true
  validates_length_of :password, in: 6..20, on: :create

  has_many :user_lists
  has_many :cards
  has_many :comments
  before_create :encrypt_password
  after_create :clear_password
  has_secure_token :auth_token

  def admin?
    self.class.name == 'Admin'
  end

  def member?
    self.class.name == 'Member'
  end

  def encrypt_password
    return if self.password.empty?
    self.salt = BCrypt::Engine.generate_salt
    self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
  end

  def clear_password
    self.password = nil
  end

  def verify_password(pwd)
    self.encrypted_password == BCrypt::Engine.hash_secret(pwd, self.salt)
  end
end
