# frozen_string_literal: true

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
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to departments_path, notice: 'Department was successfully created.'
    else
      render 'new'
    end
  end

  def update
    @department = Department.find(params[:id])
    if @department.update(department_params)
      redirect_to department_url(@department), notice: 'Department was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_path, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def department_params
    params.require(:department).permit(:name, :id)
  end
end
