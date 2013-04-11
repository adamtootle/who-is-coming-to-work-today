class EmployeesController < ApplicationController
  def register
    registration_email = "register@whoiscomingtoworktoday.com"
    if params.has_key?(:to) && params.has_key?(:from) && params.has_key?(:subject) && params.has_key?(:text) && params[:to] == registration_email

      company_name_lower = params[:subject].downcase
      company = Company.where(:name => company_name_lower).first

      if(company.nil?)
        company = Company.new
        company.name = company_name_lower
        company.save
      end

      employee = Employee.where(:email_address => params[:from]).first

      if(employee.nil?)
        employee = Employee.new
      end

      employee.name = params[:text]
      employee.email_address = params[:from]
      employee.company_id = company.id
      employee.save

    end
  end

  def list
    @employees = []
    if(params.has_key?(:company_name))
      @company = params[:company_name]
      company = Company.where(:name => @company.downcase).first
      if(!company.nil?)
        @employees = company.employees
      end
    end
  end
end
