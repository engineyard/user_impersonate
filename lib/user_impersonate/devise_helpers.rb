# TODO store staff user via Warden
module UserImpersonate
  module DeviseHelpers
    module Helpers
      def impersonate(new_user)
        session[:staff_user_id] = current_user.id # 
        sign_in new_user, bypass: true
      end
    end
    
    module UrlHelpers
      def staff_user
        return unless session[:staff_user_id]
        @staff_user ||= User.find(session[:staff_user_id])
      end
    end
  end
end