class ApplicationController < ActionController::API
  def check_auth
    token = request.headers['Authorization'].gsub('Token ', '')

    if @user = User.find_by_token(token)
      @user unless @user.token_expired?
    else
      render json: "no"
    end
  end

end
