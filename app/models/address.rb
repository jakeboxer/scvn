# A single web address. Also includes the logic to translate between numeric IDs
# and shortened ones.
#
# As a side note, our current translation scheme (which converts numeric IDs to
# string representations of pseudo-base-70 numbers) makes it impossible for a
# shortened URL to conflict with a real one.
# We prefix all unshortened URLs with /unshortened. A conflict may arise if an
# Address's ID translated to `unshortened` in our pseudo-base-70 representation.
# However, `unshortened` is the equivalent of the following numeric value:
#
# 183,120,483,659,824,076,707 (or almost two-hundred quintillion)
#
# MySQL's largest type (unsigned BIGINT) maxes out at:
#
# 18,446,744,073,709,551,615 (or just under twenty quintillion)
#
# Thus, even if each person in the world makes 3 billion URLs, they'll fill up
# the database range long before causing a collision.

class Address < ActiveRecord::Base
  # Associatons
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  has_many :visits, :dependent => :destroy
  
  # Validations
  # URL regex altered slightly from
  # http://regexlib.com/REDetails.aspx?regexp_id=96
  # Note: This is not intended to block every possible invalid URL; just grossly
  # invalid ones.
  validates_format_of :url,
    :with => /\A(http|https|ftp):\/\/[-_\w]+(\.[-_\w]+)+([-,@?^=%&:~#\/\+\w\.]*[-@?^=%&~#\/\w])?\Z/,
    :message => 'is either blank, has invalid characters, or has improper form.'
  
  # The string of tag names can have any character except for a pipe (which
  # conflicts with the jQuery autocomplete plugin)
  validates_format_of :tag_names, :with => /\A[^|]*\Z/,
    :message => "may not contain the | (pipe) character."
  
  # Callbacks
  after_save :assign_tags
  
  # Attributes
  attr_writer :tag_names
  attr_accessible :url, :tag_names
  
  def tag_names
    @tag_names || tags.map(&:name).join(', ')
  end
  
  # The number of times the site has been visited through the shortened URL
  def num_visits
    self.visits.size
  end
  
  # All the characters that are safe for URLs
  # Derived from:
  # http://www.eskimo.com/~bloo/indexdot/html/topics/urlencoding.htm
  def self.url_safe_chars
    [
      '!', "'", '(', ')', '*', '-', '.', '0', '1', '2', '3', '4', '5', '6', '7',
      '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
      'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '_', 'a',
      'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
      'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    ]
  end
  
  # Converts a numerical value to a string representation of the equivalent
  # base-X number (where X is the number of URL-safe characters).
  # Note: This is not a traditional base-X number; rather than starting with 0,
  # it starts with the first URL-safe character.
  def self.id_to_shortened (id)
    safe_chars      = Address.url_safe_chars
    shortened_chars = []
    
    # Run through the id, converting to base-X digits and then shifting
    while id > 0
      shortened_chars.unshift(safe_chars[(id % safe_chars.length)])
      id /= safe_chars.length
    end
    
    shortened_chars.join('')
  end
  
  # Converts a string representation of a base-X number (as described in
  # id_to_shortened) to the equivalent numerical value.
  def self.shortened_to_id (shortened)
    safe_char_vals  = Address.url_safe_char_values
    shortened_chars = shortened.split('')
    id              = 0
    
    # Run through the shortened id, converting from base-X digits to numerical
    # values
    while not shortened_chars.empty?
      id *= safe_char_vals.length
      id += safe_char_vals[shortened_chars.shift]
    end
    
    id
  end
  
  # Finds the URL with the specified shortened id
  def self.find_by_shortened (shortened)
    Address.find(Address.shortened_to_id(shortened))
  end
  
  # The shortened id of the Address
  def shortened
    Address.id_to_shortened self.id
  end
  
  # Always use the shortened id instead of the regular one for parameters
  def to_param
    self.shortened
  end
  
  private
  
  # The ASCII codes of all the characters that are safe for URLs.
  def self.url_safe_codes
    codes_from_chars(Address.url_safe_chars)
  end
  
  # Mapped values for all the URL-safe characters
  def self.url_safe_char_values
    safe_chars  = Address.url_safe_chars
    char_values = {}
    
    # Assign each character a value equal to its index in the array
    safe_chars.each_index {|i| char_values[safe_chars[i]] = i}
    char_values
  end
  
  # Convert a string of comma-and-whitespace-separated words into tags (creating
  # any that don't already exist)
  def assign_tags
    if @tag_names
      # Split our tag name string on commas surrounded by any amount of
      # whitespace and eliminate any tags that are either empty or made up 
      # entirely of whitespace
      cleaned   = @tag_names.split(/\s*,\s*/).select {|name| name =~ /[^\s]/ }
      self.tags = cleaned.collect do |name|
        Tag.find_or_create_by_name(name.downcase)
      end
    end
  end
end
