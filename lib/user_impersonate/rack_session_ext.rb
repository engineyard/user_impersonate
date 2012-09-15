module UserImpersonate
  module RackSessionExt
    attr_reader :env

    def user
      @user ||= load_user
    end

    def load_user
      user = User.get(self[:user_id])
      self[:user_id] = user.id if user
      user
    end

    def staff_user
      return unless self[:staff_user_id]
      @staff_user ||= User.get(self[:staff_user_id])
    end

    def impersonate(new_user)
      self[:staff_user_id] ||= user.id
      self[:user_id] = new_user.id
      ey_sso.login_as(new_user.salesforce_id)
      @user = nil
    end

    def revert
      old_user = user
      self[:user_id] = staff_user.id
      self[:staff_user_id] = nil
      @user = staff_user
      @staff_user = nil
      old_user
    end
  end
end
