require 'test_helper'

class DefinitionsControllerTest < ActionController::TestCase
  setup do
    @definition = definitions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:definitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create definition" do
    assert_difference('Definition.count') do
      post :create, definition: {  }
    end

    assert_redirected_to definition_path(assigns(:definition))
  end

  test "should show definition" do
    get :show, id: @definition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @definition
    assert_response :success
  end

  test "should update definition" do
    patch :update, id: @definition, definition: {  }
    assert_redirected_to definition_path(assigns(:definition))
  end

  test "should destroy definition" do
    assert_difference('Definition.count', -1) do
      delete :destroy, id: @definition
    end

    assert_redirected_to definitions_path
  end
end
