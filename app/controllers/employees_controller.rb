# app/controllers/employees_controller.rb
# frozen_string_literal: true

class EmployeesController < ApplicationController
  # Public pages
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_employee, only: %i[show edit update destroy]

  # GET /employees
  def index
    @employees = apply_sort(Employee.includes(:department))
  end

  # GET /employees/1
  def show; end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit; end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employees_path, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @employee.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /employees/:id
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employees_path, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @employee.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def apply_sort(scope)
    case sort_param
    when 'departments.name'
      scope.left_joins(:department)
           .order(Department.arel_table[:name].send(sort_direction))
    when *column_map.keys
      scope.order(column_map[sort_param] => sort_direction)
    else
      scope.order(:lastname)
    end
  end

  def column_map
    {
      'lastname' => :lastname,
      'firstname' => :firstname,
      'email' => :email,
      'phone' => :phone,
      'title' => :title,
      'department_id' => :department_id
    }
  end

  def sort_param
    params[:sort].to_s
  end

  def sort_direction
    dir = params[:direction].to_s.casecmp('desc').zero? ? :desc : :asc
    %i[asc desc].include?(dir) ? dir : :asc
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.expect(employee: %i[lastname firstname email department_id phone title])
  end
end
