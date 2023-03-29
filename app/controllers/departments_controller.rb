class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
  end

  def show
    @department = Department.find(params[:id])
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if @department.update(department_params)
      redirect_to @department
    else
      render 'edit'
    end
  end

  private

  def department_params
    params.require(:department).permit(:name, :description)
  end
end
