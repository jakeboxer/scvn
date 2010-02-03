# Used to mark an Address with different meanings of items of interest.
class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :addresses, :through => :taggings
  
  # A tag name must be at least one character long and contain no commas
  validates_format_of :name, :with => /\A[^,]+\Z/
  
  attr_accessible :name
end
