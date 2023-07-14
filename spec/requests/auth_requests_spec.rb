RSpec.describe "/auth/*", type: :request do
  before(:all) do
    @user = User.first_or_create(email: "gerard@avionschool.com",
                       password: "password",
                       password_confirmation: "password")
  end

  context "reset pasword request" do
    it "can receive a reset pasword request with a valid email" do
      post auth_reset_password_request_path, params: { email: "gerard@avionschool.com" }

      @user.reload

      expect(response).to have_http_status(200)
      expect(response.body).to include(@user.reset_password_token)
    end

    it "will not generate a reset password token for invalid email" do
      post auth_reset_password_request_path, params: { email: "unknown@avionschool.com" }

      expect(response).to have_http_status(404)
      expect(response.body).to include("not found")
    end
  end

  context "reset password" do
    it "can receive a reset password token and the new password and the password confirmation" do
      post auth_reset_password_request_path, params: { email: "gerard@avionschool.com" }

      @user.reload

      post auth_reset_password_path, params: {
                                  password_token: @user.reset_password_token,
                                  password: "new_password",
                                  password_confirmation: "new_password"
                                }

      expect(response).to have_http_status(200)
      expect(response.body).to include("success")

      auth_token = User.get_authentication_token(email: @user.email, password: "new_password")

      @user.reload

      expect(@user.token).to eq(auth_token)
    end
  end
end
