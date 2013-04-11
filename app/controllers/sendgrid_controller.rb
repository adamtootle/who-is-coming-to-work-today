class SendgridController < ApplicationController
  def parse
    registration_email = "register@whoiscomingtoworktoday.com"
    checkin_email = "checkin@whoiscomingtoworktoday.com"

    if params.has_key?(:to) && params.has_key?(:from) && params.has_key?(:text)

      if params[:to] == registration_email
        register_employee
      end

      if params[:to] == checkin_email
        checkin_employee
      end

    end
  end

  private
  def register_employee
    if params.has_key?(:subject)
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

  def checkin_employee
    tokens = params[:text].split(' ')

    if tokens.any?
      employee = Employee.where(:email_address => params[:from]).first

      checkin = Checkin.new
      checkin.employee_id = employee.id
      
      if tokens.first.downcase == 'y' || tokens.first.downcase == 'yes'
        checkin.is_coming = true
      elsif tokens.first.downcase == 'n' || tokens.first.downcase == 'no'
        checkin.is_coming = false
      end

      if !tokens.at(1).nil?
        message = ""
        tokens[1..tokens.length].each do |t|
          message.concat "#{t} "
        end
        message.chomp!(' ')
        checkin.message = message
      end

      checkin.save
    end
  end
end
