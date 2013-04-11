class Employee < ActiveRecord::Base
  belongs_to :company

  attr_accessible :company_id, :email_address, :name
end
