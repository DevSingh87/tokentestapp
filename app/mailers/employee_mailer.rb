class EmployeeMailer < ApplicationMailer

 def employee_creation_email_confirmation(employee)
    @employee = employee
    mail(:to => "#{employee.name} <#{employee.email}>", :subject => "Employee Creation Confirmation")
 end
end
