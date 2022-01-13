require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Users with different IDs have different marks" do
    user1 = User.new(email: "user1@gmail.com", password: "123456")
    user2 = User.new(email: "user2@gmail.com", password: "123456")
    user1.save!
    user2.save!
    assert user1.mark_shape != user2.mark_shape
  end
end
