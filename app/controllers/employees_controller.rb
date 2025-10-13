# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy]

  # GET /employees or /employees.json
  def index
    # Base scope: eager-load department to avoid N+1 queries in the view
    @employees = Employee.includes(:department)

    # Whitelist of sortable columns mapped to SQL-safe expressions
    sortable_map = {
      'lastname'         => 'employees.lastname',
      'firstname'        => 'employees.firstname',
      'email'            => 'employees.email',
      'phone'            => 'employees.phone',
      'title'            => 'employees.title',
      'department_id'    => 'employees.department_id',
      'departments.name' => 'departments.name'
    }

    sort_param = params[:sort].presence || 'lastname'
    sort_sql   = sortable_map[sort_param] || sortable_map['lastname']
    direction  = %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'

    if sort_sql == 'departments.name'
      # Keep includes(:department) for preload; add a LEFT OUTER JOIN only for this sort
      @employees = @employees.left_outer_joins(:department)
                             .order(Arel.sql("#{sort_sql} #{direction} NULLS LAST"), :lastname)
    else
      @employees = @employees.order(Arel.sql("#{sort_sql} #{direction}"))
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
