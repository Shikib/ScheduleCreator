require 'test_helper'

class TutorialSectionsControllerTest < ActionController::TestCase
  setup do
    @tutorial_section = tutorial_sections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tutorial_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tutorial_section" do
    assert_difference('TutorialSection.count') do
      post :create, tutorial_section: {  }
    end

    assert_redirected_to tutorial_section_path(assigns(:tutorial_section))
  end

  test "should show tutorial_section" do
    get :show, id: @tutorial_section
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tutorial_section
    assert_response :success
  end

  test "should update tutorial_section" do
    patch :update, id: @tutorial_section, tutorial_section: {  }
    assert_redirected_to tutorial_section_path(assigns(:tutorial_section))
  end

  test "should destroy tutorial_section" do
    assert_difference('TutorialSection.count', -1) do
      delete :destroy, id: @tutorial_section
    end

    assert_redirected_to tutorial_sections_path
  end
end
