# Used to mark an Address with different meanings of items of interest.
class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :addresses, :through => :taggings
  
  # A tag name must be at least one character long and contain no commas or pipe
  # characters (pipe characters conflict with the jQuery autocomplete plugin)
  validates_format_of :name, :with => /\A[^,|]+\Z/
  validates_uniqueness_of :name, :case_sensitive => false
  
  attr_accessible :name
end
