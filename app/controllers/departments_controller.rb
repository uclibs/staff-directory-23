class DepartmentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @departments = Department.all
  end

  def show
    @department = Department.find(params[:id])
   
  end

  def edit
    @department = Department.find(params[:id])
  end
# GET /department/new
 def new
  @department = Department.new(name: "")
    redirect_to @department
 end

 def create
  @department = Department.new(department_params)
  if @department.save
    redirect_to @department
  else
    render 'new'
  end
end


  def update
    @department = Department.find(params[:id])
    if @department.update(department_params)
      redirect_to @department
    else
      render 'edit'
    end
  end
    
def destroy
  @department = Department.find(params[:id])
  @department.destroy
  respond_to do |format|
    format.html { redirect_to departments_path, notice: "Department was successfully destroyed." }
    format.json { head :no_content }
  end
end

  end      
  private

  def department_params
    params.require(:department).permit(:name, :description)
  end