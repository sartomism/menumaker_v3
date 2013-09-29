require 'test_helper'

class BloquecomidasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bloquecomidas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bloquecomida" do
    assert_difference('Bloquecomida.count') do
      post :create, :bloquecomida => { }
    end

    assert_redirected_to bloquecomida_path(assigns(:bloquecomida))
  end

  test "should show bloquecomida" do
    get :show, :id => bloquecomidas(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bloquecomidas(:one).id
    assert_response :success
  end

  test "should update bloquecomida" do
    put :update, :id => bloquecomidas(:one).id, :bloquecomida => { }
    assert_redirected_to bloquecomida_path(assigns(:bloquecomida))
  end

  test "should destroy bloquecomida" do
    assert_difference('Bloquecomida.count', -1) do
      delete :destroy, :id => bloquecomidas(:one).id
    end

    assert_redirected_to bloquecomidas_path
  end
end
