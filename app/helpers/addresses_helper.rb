module AddressesHelper
  def twitter_url (address)
    hashtags = address.tags.map {|tag| "##{tag.name}"}
    tag_txt  = hashtags.join(' ')
    tweet    = URI.encode("Check out #{goto_shortened_url(address)} #{tag_txt}")
    txt      = truncate(tweet, :length => 140, :omission => '..')
    "http://twitter.com/?status=#{txt}"
  end
end
