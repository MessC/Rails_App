require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
	# 11.2 Tests for the validity of a new micropost 
	def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum") # 11.11: Using idiomatically correct code to (build a micropost) from table 11.1
	end

	test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

	# 11.3 Tests for the Micropost model validations
	test "content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

	# 11.13 Testing the micropost order
	test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

end
