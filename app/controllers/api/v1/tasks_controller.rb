module Api
  module V1
    class TasksController < Api::BaseController
      before_action :set_task, only: [:show, :update, :destroy]
      
      def index
        @tasks = if params[:user_id]
                  User.find(params[:user_id]).tasks
                else
                  current_user.role == 'admin' ? Task.all : current_user.tasks
                end
        
        @tasks = @tasks.where(status: params[:status]) if params[:status].present?
        @tasks = @tasks.where('due_date >= ?', params[:start_date]) if params[:start_date].present?
        @tasks = @tasks.where('due_date <= ?', params[:end_date]) if params[:end_date].present?
        
        @tasks = @tasks.page(params[:page] || 1).per(params[:per_page] || 10)
        
        render json: @tasks
      end
      
      def show
        render json: @task, include_user: true
      end
      
      def create
        @task = Task.new(task_params)
        @task.user = params[:user_id] ? User.find(params[:user_id]) : current_user
        
        if @task.save
          render json: @task, status: :created
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      def update
        if @task.update(task_params)
          render json: @task
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      def destroy
        @task.destroy
        head :no_content
      end
      
      private
      
      def set_task
        @task = if current_user.role == 'admin'
                 Task.find(params[:id])
               else
                 current_user.tasks.find(params[:id])
               end
      end
      
      def task_params
        params.require(:task).permit(:title, :description, :status, :due_date)
      end
    end
  end
end