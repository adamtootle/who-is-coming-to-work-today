class Checkin < ActiveRecord::Base
  belongs_to :employee

  attr_accessible :message, :employee_id, :is_coming
end
