require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    User.first_or_create(email: "gerard@avionschool.com",
             password: "password",
             password_confirmation: "password")
  }

  context "reset password" do
    it "can generate a reset_password_token" do
      expect(user.generate_reset_password_token!).to_not be nil
    end

    it "has a reset password token" do
      user.generate_reset_password_token!

      expect(user.reset_password_token).to_not be nil
    end
  end
end
