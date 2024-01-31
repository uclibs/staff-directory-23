# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy]

  # GET /employees or /employees.json
  def index
    @employees = Employee.all
    # return unless params[:sort].present?
    # Whitelist of sortable columns
    sortable_columns = ['lastname', 'firstname', 'email', 'phone', 'title', 'department_id', 'departments.name']
    sort_column = params[:sort] || 'lastname' # Default sort column
    direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    return unless sortable_columns.include?(sort_column)

    @employees = if sort_column == 'departments.name'
                   # Join with the departments table and sort by department name
                   @employees.joins(:department).order("departments.name #{direction}")
                 else
                   # Sort by employee attributes
                   @employees.order("#{sort_column} #{direction}")
                 end
  end

  # GET /employees/1 or /employees/1.json
  def show; end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit; end

  # POST /employees or /employees.json
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

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:lastname, :firstname, :email, :department_id, :phone, :title)
  end
end
