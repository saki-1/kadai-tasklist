class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def index
    if logged_in?
    # @tasks = Task.all
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order(id: :desc)
    end
  end
  
  def create
    @task = current_user.tasks.build(task_paramas)
    
    if @task.save
      flash[:success] = 'Taskが正常に投稿されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc)
      flash.now[:danger] = 'Taskが投稿されませんでした'
      render 'tasks/index'
    end
    
  end
  
  def new
    @task = Task.new
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_paramas)
      flash[:success] = 'Taskが正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Taskが更新されませんでした'
      render :new
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_path
  end
  
  private
  def task_paramas
    params.require(:task).permit(:content, :status)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
