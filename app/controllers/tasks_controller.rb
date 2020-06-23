class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def create
    @task = Task.new(task_paramas)
    
    if @task.save
      flash[:success] = 'Taskが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが投稿されませんでした'
      render :new
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
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが更新されませんでした'
      render :new
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_path
  end
  
  private
  def task_paramas
    params.require(:task).permit(:content, :status)
  end
end
