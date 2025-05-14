module Api
  module V1
    class UsersController < Api::BaseController
      before_action :set_user, only: [:show, :update, :destroy]
      before_action :authorize_admin, except: [:index, :show]
      
      def index
        @users = User.all.page(params[:page] || 1).per(params[:per_page] || 10)
        render json: @users
      end
      
      def show
        render json: @user, include_tasks: true
      end
      
      def create
        @user = User.new(user_params)
        
        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      def destroy
        @user.destroy
        head :no_content
      end
      
      private
      
      def set_user
        @user = User.find(params[:id])
      end
      
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :role)
      end
      
      def authorize_admin
        unless current_user.role == 'admin'
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end
    end
  end
end