require "base64"
require "bcrypt"

class User < ApplicationRecord
  include BCrypt

  # has_secure_password # :default

  after_create :generate_token

  def generate_token
    self.token = Base64.encode64(self.email + '_avion1');
    self.token_expiration = Rails.application.config.auth_token_expiration # => 1.minute
    
    self.save
  end

  def verify_password(password, password_confirmation)
    if password == password_confirmation
      self.password_digest = BCrypt::Password.create(password)
    end
  end

end
