class AuthController < ApplicationController
  # where @current_user comes from
  before_action :check_auth, only: [:current, :signout]
  
  def signup
    @user = User.new(signup_params)
    
    if @user.verify_password(signup_params[:password], signup_params[:password_confirmation])
      if @user.save
        render json: { token: @user.token }
      else
        render json: @user.errors, status: 422
      end
    else
      render json: { password: "doesn't match" }, status: 422
    end
  end

  def signin
    if @user_token = User.get_authentication_token(signin_params)
      render json: { token: @user_token }
    else
      render json: "no", status: 404
    end
  end

  def current
    render json: @current_user, except: [:password_digest, :token]
  end

  def signout
    if @current_user.update(token: nil)
      render json: { signout: true }
    else
      render json: { error: "not found"}
    end
  end

  def reset_password_request
    user = User.find_by_email(params[:email])

    if user.nil?
      render json: { error: "not found" }, status: 404
    else
      user.generate_reset_password_token!

      render json: { token: user.reset_password_token }, status: 200
    end
  end

  def reset_password
    user = User.find_by_reset_password_token(params[:password_token])

    if user.nil?

    else
      if user.verify_password(params[:password], params[:password_confirmation])
        if user.save
          render json: { success: true }
        else
          render json: { errors: user.errors }
        end
      else
        render json: { error: "passwords don't match"}
      end
    end
  end

  private
  def signup_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def signin_params
    params.require(:user).permit(:email, :password)
  end
end
