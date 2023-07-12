class ApplicationController < ActionController::API
  def check_authentication
    # render json: { token: "not found" } if request.headers['Authorization'].nil?

    token = request.headers['Authorization'].gsub('Token ', '')

    if @current_user = User.find_by_token(token)
      if @current_user.token_expired?
        render json: { token: "expired" }
      end
    else
      render json: { user: "not found" }
    end
  end

  def current_user
    @current_user
  end

  def unauthorized
    render json: { user: "unauthorized" }, status: 422
  end
end
