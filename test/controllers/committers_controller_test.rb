require 'test_helper'

class CommittersControllerTest < ActionController::TestCase
  setup do
    @committer = committers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:committers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create committer" do
    assert_difference('Committer.count') do
      post :create, committer: { email: @committer.email, name: @committer.name, username: @committer.username }
    end

    assert_redirected_to committer_path(assigns(:committer))
  end

  test "should show committer" do
    get :show, id: @committer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @committer
    assert_response :success
  end

  test "should update committer" do
    patch :update, id: @committer, committer: { email: @committer.email, name: @committer.name, username: @committer.username }
    assert_redirected_to committer_path(assigns(:committer))
  end

  test "should destroy committer" do
    assert_difference('Committer.count', -1) do
      delete :destroy, id: @committer
    end

    assert_redirected_to committers_path
  end
end
