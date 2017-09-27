require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "Example User", birthday: "01-02-1997", is_female: true,
                     email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "         "
    assert_not @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = "       "
    assert @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "  3"
    assert @user.valid?
  end

end
