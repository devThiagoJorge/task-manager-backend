class Api::V1::UsersController < ApplicationController
    respond_to :json

    def show
        begin
            @user = User.find(params[:id])
            respond_with @user # return 200
        rescue => exception
            head 404
        end
    end

    def create
        begin
             user = User.new(user_params)
        if user.save
            return render json: user, status: 201
        end 
        rescue => exception
             head 400
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
    
end
