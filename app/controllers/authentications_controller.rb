class AuthenticationsController < ApplicationController
    before_action :authorize_request, except: :login

    skip_before_action :verify_authenticity_token

    # POST /auth/login
    def login

    @doctor = Doctor.find_by_email(params[:email])

    puts "---- #{params[:password]} doctor=#{@doctor.password}----"

      if @doctor.password && @doctor.password==params[:password]
        token = JsonWebToken.encode(doctor_id: @doctor.id)

        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                       doctor_name: @doctor.name }, status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
    def login_params
      params.permit(:email, :password)
    end
end