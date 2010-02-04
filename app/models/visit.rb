# Represents a single visit to an address
class Visit < ActiveRecord::Base
  belongs_to :address
end
