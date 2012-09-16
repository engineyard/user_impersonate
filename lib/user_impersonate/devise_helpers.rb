# TODO store staff user via Warden
module UserImpersonate
  module DeviseHelpers
    module Helpers
      # current_user changes from a staff user to
      # +new_user+; current user stored in +session[:staff_user_id]+
      def impersonate(new_user)
        session[:staff_user_id] = current_user.id # 
        sign_in new_user, bypass: true
      end
      
      # revert the +current_user+ back to the staff user
      # stored in +session[:staff_user_id]+
      def revert_impersonate
        return unless current_staff_user
        sign_in current_staff_user, bypass: true
        session[:staff_user_id] = nil
      end
    end
    
    module UrlHelpers
      def current_staff_user
        return unless session[:staff_user_id]
        @staff_user ||= User.find(session[:staff_user_id])
      end
    end
  end
end