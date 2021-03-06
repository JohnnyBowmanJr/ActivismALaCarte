class ApplicationController < ActionController::Base
  protect_from_forgery

  # this hits after users are signed in through Facebook
  def after_sign_in_path_for(resource)
    if request.env["omniauth.auth"]
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    else
      sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
      if request.referer == sign_in_url
        super
      else
        stored_location_for(resource) || request.referer || root_path
      end
    end
    
  end
end
