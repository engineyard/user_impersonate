require 'test_helper'

module UserImpersonate
  class ImpersonateControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  
  end
end
