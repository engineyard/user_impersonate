require 'test_helper'

module UserTakeover
  class TakeoverControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  
  end
end
