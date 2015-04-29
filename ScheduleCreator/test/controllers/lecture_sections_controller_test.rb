require 'test_helper'

class LectureSectionsControllerTest < ActionController::TestCase
  setup do
    @lecture_section = lecture_sections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lecture_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lecture_section" do
    assert_difference('LectureSection.count') do
      post :create, lecture_section: {  }
    end

    assert_redirected_to lecture_section_path(assigns(:lecture_section))
  end

  test "should show lecture_section" do
    get :show, id: @lecture_section
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lecture_section
    assert_response :success
  end

  test "should update lecture_section" do
    patch :update, id: @lecture_section, lecture_section: {  }
    assert_redirected_to lecture_section_path(assigns(:lecture_section))
  end

  test "should destroy lecture_section" do
    assert_difference('LectureSection.count', -1) do
      delete :destroy, id: @lecture_section
    end

    assert_redirected_to lecture_sections_path
  end
end
