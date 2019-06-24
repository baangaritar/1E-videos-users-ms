class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login
  
    # POST /auth/login
    def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
            token = JsonWebToken.encode(user_id: @user.id)
            time = Time.now + 24.hours.to_i
            render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                        username: @user.username }, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end

  # Verify if JWT is valid or not
  def verify
        is_valid = Token.verify_token(params[:jwt])

        if(is_valid == true)
            response =  { content: "Valid", message: "JWT is valid", status: 200 } # Return JWT

            render json: response, status: 200
        else
            response =  { content: "No valid", message: "JWT is not valid", status: 400 } # Return JWT

            render json: response, status: 400
        end
    end

    private
  
    def login_params
        params.permit(:email, :password, :jwt)
    end
  end