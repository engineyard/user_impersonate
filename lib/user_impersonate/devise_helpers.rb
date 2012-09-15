# TODO store staff user via Warden
module UserImpersonate
  module DeviseHelpers
    module Helpers
      def impersonate(new_user)
        puts "impersonate(#{new_user.inspect})"
        session[:staff_user_id] = current_user.id # 
        sign_in new_user, bypass: true
        # warden.set_user(staff_user, scope: "staff_user")
        # warden.set_user(new_user)
        p session
      end
    end
    
    module UrlHelpers
      def staff_user
        return unless session[:staff_user_id]
        p session
        @staff_user ||= User.find(session[:staff_user_id])
      end
    end
  end
end