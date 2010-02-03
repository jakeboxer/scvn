class Address < ActiveRecord::Base
  
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
  
  def self.find_by_shortened (shortened)
    Address.find(Address.shortened_to_id(shortened))
  end
  
  def shortened
    Address.id_to_shortened self.id
  end
  
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
  
end
