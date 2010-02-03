# Represents a single Address being tagged with a single Tag
class Tagging < ActiveRecord::Base
  belongs_to :address
  belongs_to :tag
  
  # Block any attributes from being mass-assigned
  attr_accessible 
end
