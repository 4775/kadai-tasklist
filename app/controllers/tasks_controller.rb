class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @user = current_user
    @tasks = @user.tasks.order('created_at DESC').page(params[:page])
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に追加されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの追加ができませんでした'
      render :new
    end
  end

  def edit
  end

  def update

    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'タスクの完了が実行されました'
    redirect_to tasks_url
  end
  
  private
  def set_task
     @task = Task.find(params[:id])
  end
   
  def task_params
    params.require(:task).permit(:status, :content)
  end
end
