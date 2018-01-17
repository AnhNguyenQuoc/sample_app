module SessionsHelper
    
    
    #Logs in the given user
    def log_in(user)
        session[:user_id] = user.id
    end
    
    
    #Remember User in a presistent session.
    
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end
    
    
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    # Returns the user corresponding to the remember token cookie.
    
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: session[:user_id])
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end
    
    #Return true if user is current user
    
    def current_user?(user)
        user == current_user
    end
    
    #Return true if the user is logged in
    def logged_in?
        !current_user.nil?
    end
    
    
    #Log out
    def log_out
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
    end
    
    
    #Redirect to stored location (or to the default)
    def redirect_back_or(default)
       redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end
    
    #Store the URL trying to accessed
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end
end