class AuthController < ApplicationController
  
  def signup
    @user = User.new(signup_params)

    if @user.verify_password(signup_params)
      if @user.save
        render json: { token: @user.token }
      else
        render json: "no", status: 404
      end
    end
  end

  def login
    
  end


  private
  def signup_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
