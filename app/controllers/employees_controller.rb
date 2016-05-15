class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
       EmployeeMailer.employee_creation_email_confirmation(@employee).deliver
       flash[:notice] = "Please confirm your email address to continue"
       redirect_to root_url
    else
        flash[:error] = "Ooooppss, something went wrong!"
        render 'new'
    end

    
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
      @employee = Employee.find_by_id(params[:id])
      @employee.assign_attributes(employee_params)
      
        if @employee.email_changed? || @employee.phone_number_changed?
          if @employee.save
          @employee.email_deactivate
          EmployeeMailer.employee_creation_email_confirmation(@employee).deliver
          flash[:notice] = "Please confirm your email address to continue"
          redirect_to root_url
        else
         flash[:error] = "Ooooppss, something went wrong!"
         render :edit
        end
          
      else
       if @employee.save
         flash[:notice] = "Updated successfully"
         redirect_to root_url
       else
         flash[:error] = "Ooooppss, something went wrong!"
         render :edit
      end
     end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def verify_email_phone_number
    employee = Employee.find_by_verify_token(params[:id])
    if employee
      if employee.email_phone_number_verified?
        flash[:error] = "Already verified."
        redirect_to root_url
      else
        employee.email_activate
        flash[:notice] = "Welcome to the Token App! Your email has been verified."
        redirect_to root_url
      end
    else
      flash[:error] = "Sorry. Employee does not exist"
      redirect_to root_url
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :email, :date_of_birth, :location, :phone_number)
    end
end
