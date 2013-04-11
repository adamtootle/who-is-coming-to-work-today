class EmployeesController < ApplicationController
  def register

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
