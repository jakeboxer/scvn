# Represents a single visit to an address
class Visit < ActiveRecord::Base
  belongs_to :address
  
  # None of the attributes should be mass-assignable
  attr_accessible
end
