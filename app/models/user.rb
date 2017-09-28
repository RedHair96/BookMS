class User < ApplicationRecord
  # Inform association with books table
  has_many :books

  # Allow virtual attribute
  attr_accessor :remember_token

  # Validation
  validates :name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  # Use bcrypt for digest password, authenticate,
  # Allow virtual attribute (password, password_confirmation)
  has_secure_password
  validates :password, presence: true, length: { minimum: 6}

  # Class method
  class << self
    # Return the hash digest of the given string.
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Return secure random token
    def User.secure_token
      SecureRandom.urlsafe_base64
    end
  end

  # Remember current use in database
  def remember
    self.remember_token = User.secure_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  # Authenticate remember_token
  def authenticated?(cookies_remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(cookies_remember_token)
  end

  # Forget remember_token
  def forget
    update_attribute(:remember_digest, nil)
  end
end