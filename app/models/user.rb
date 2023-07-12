require "securerandom"
require "bcrypt"

class User < ApplicationRecord
  attr_accessor :password, :password_confirmation

  include BCrypt

  has_many :articles

  before_create :verify_password
  after_create :generate_token

  def password
    @password ||= Password.new(password_digest)
  end

  def self.get_authentication_token(signin_params)
    current = User.find_by_email(signin_params[:email])

    if current.present?
      if current.password == signin_params[:password]
        current.generate_token

        return current.token
      else
        return "invalid"
      end
    else
      return "not found"
    end
  end

  def generate_token
    self.token = SecureRandom.base64[0..32];
    self.token_expiration = DateTime.now + Rails.application.config.auth_token_expiration
                            # => DateTime.now + 2.weeks
    
    self.save
  end

  def verify_password
    if self.password == self.password_confirmation
      self.password_digest = BCrypt::Password.create(password)
    end
  end


  def token_expired?
    token_expiration < Time.now
  end

  def admin?
    self.role == "admin"
  end

  def user?
    self.role == "user"
  end
end
