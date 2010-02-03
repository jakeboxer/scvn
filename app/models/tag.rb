class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :addresses, :through => :taggings
end
