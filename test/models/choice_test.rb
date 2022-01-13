require "test_helper"

class ChoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should not allow a mark that is not cross, circle or null" do
    choice = Choice.new(position: 1, mark: "wrong" )
    assert_not choice.save
  end

  test "Should not allow a position that is not within the game (upper end)" do
    choice = Choice.new(position: 10, mark: "cross" )
    assert_not choice.save
  end

  test "Should not allow a position that is not within the game (lower end)" do
    choice = Choice.new(position: 0, mark: "cross" )
    assert_not choice.save
  end

  test "Should not allow an empty choice to be made" do
    choice = Choice.new()
    assert_not choice.save
  end

  test 'Should allow to save a valid position and mark' do
    choice = Choice.new(position: 2, mark: "cross")
    assert choice.save
  end
end
