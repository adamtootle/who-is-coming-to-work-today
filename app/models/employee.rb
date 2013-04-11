class Employee < ActiveRecord::Base
  belongs_to :company
  has_many :checkins

  attr_accessible :company_id, :email_address, :name
end
