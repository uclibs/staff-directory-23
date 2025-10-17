# frozen_string_literal: true

class EmployeesController < ApplicationController
  # Allow public access to the employee listing and profile pages
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_employee, only: %i[show edit update destroy]

  # GET /employees
  def index
    base_scope = Employee.includes(:department)

    # Whitelist sortable columns (own table)
    column_map = {
      'lastname' => :lastname,
      'firstname' => :firstname,
      'email' => :email,
      'phone' => :phone,
      'title' => :title,
      'department_id' => :department_id
    }
    sort_param = params[:sort].to_s
    dir_param  = params[:direction].to_s.downcase == 'desc' ? :desc : :asc

    @employees =
      if sort_param == 'departments.name'
        # Validated direction; column is fixed string so safe
        base_scope.left_joins(:department)
                  .order("departments.name #{dir_param}")
      elsif (column = column_map[sort_param])
        base_scope.order(column => dir_param)
      else
        base_scope.order(:lastname)
      end
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
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
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
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
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

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:lastname, :firstname, :email, :department_id, :phone, :title)
  end
end
