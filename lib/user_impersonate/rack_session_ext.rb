module UserImpersonate
  module RackSessionExt
    attr_reader :env

    def user
      @user ||= load_user
    end

    def load_user
      user = User.find(self[:user_id])
      self[:user_id] = user.id if user
      user
    end

    def staff_user
      return unless self[:staff_user_id]
      @staff_user ||= User.find(self[:staff_user_id])
    end

    def impersonate(new_user)
      puts "impersonate(#{new_user.inspect})"
      p self
      p self.class.ancestors
      warden.set_user(staff_user, scope: "staff_user")
      warden.set_user(user)

      self[:staff_user_id] ||= current_user.id
      self[:user_id] = new_user.id
      ey_sso.login_as(new_user.salesforce_id)
      @user = nil
    end

    def revert
      old_user = current_user
      self[:user_id] = staff_user.id
      self.current_user = staff_user
      self[:staff_user_id] = nil
      @user = staff_user
      @staff_user = nil
      old_user
    end

    def warden
      request.env['warden']
    end
  end
end
