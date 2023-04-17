class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]

  # GET /employees or /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
def update
  # Find the employee record that should be updated based on the `id` parameter passed in from the form
@employee = Employee.find(params[:id])
  # Get the ID of the department that the employee should be assigned to from the `department_id` parameter passed in from the form
department_id = params[:employee][:department_id]
  # Find the Department record that corresponds to the ID passed in from the form
department = Department.find(department_id)
  # Set the department association of the employee record to the department that was just found
@employee.department = department
  # If the update of the employee attributes (e.g. first name, last name) is successful, redirect the user to the employee's show page
if @employee.update(employee_params)
    redirect_to @employee
  else
    #display that there is a problem
    flash[:error] = "Update not successful"
   # If the update is not successful, re-render the edit form so that the user can fix any errors
    render 'edit'
  end
end



  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
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
  params.require(:employee).permit(:lastname, :firstname, :department, :email, :phone, :title)
 end 
end
