require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    get signin_path
    assert_template 'sessions/new'
    post signin_path, params: {session: {email: "", password: ""}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get signin_path
    post signin_path, params: {session: {email: @user.email, password: 'password'}}
    assert_redirected_to root_path
  end
end
