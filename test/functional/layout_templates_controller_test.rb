require 'test_helper'

class LayoutTemplatesControllerTest < ActionController::TestCase
  setup do
    @layout_template = layout_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:layout_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create layout_template" do
    assert_difference('LayoutTemplate.count') do
      post :create, layout_template: { layout_option_template: @layout_template.layout_option_template }
    end

    assert_redirected_to layout_template_path(assigns(:layout_template))
  end

  test "should show layout_template" do
    get :show, id: @layout_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @layout_template
    assert_response :success
  end

  test "should update layout_template" do
    put :update, id: @layout_template, layout_template: { layout_option_template: @layout_template.layout_option_template }
    assert_redirected_to layout_template_path(assigns(:layout_template))
  end

  test "should destroy layout_template" do
    assert_difference('LayoutTemplate.count', -1) do
      delete :destroy, id: @layout_template
    end

    assert_redirected_to layout_templates_path
  end
end
