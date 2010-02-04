class ApplicationController < ActionController::Base
  layout 'public'
  helper :all # include all helpers, all the time
  protect_from_forgery
end
