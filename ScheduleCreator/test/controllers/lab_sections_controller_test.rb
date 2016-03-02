require 'test_helper'

class LabSectionsControllerTest < ActionController::TestCase
  setup do
    @lab_section = lab_sections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lab_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lab_section" do
    assert_difference('LabSection.count') do
      post :create, lab_section: {  }
    end

    assert_redirected_to lab_section_path(assigns(:lab_section))
  end

  test "should show lab_section" do
    get :show, id: @lab_section
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lab_section
    assert_response :success
  end

  test "should update lab_section" do
    patch :update, id: @lab_section, lab_section: {  }
    assert_redirected_to lab_section_path(assigns(:lab_section))
  end

  test "should destroy lab_section" do
    assert_difference('LabSection.count', -1) do
      delete :destroy, id: @lab_section
    end

    assert_redirected_to lab_sections_path
  end
end
