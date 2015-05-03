require 'test_helper'

class RequiredCoursesControllerTest < ActionController::TestCase
  setup do
    @required_course = required_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:required_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create required_course" do
    assert_difference('RequiredCourse.count') do
      post :create, required_course: {  }
    end

    assert_redirected_to required_course_path(assigns(:required_course))
  end

  test "should show required_course" do
    get :show, id: @required_course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @required_course
    assert_response :success
  end

  test "should update required_course" do
    patch :update, id: @required_course, required_course: {  }
    assert_redirected_to required_course_path(assigns(:required_course))
  end

  test "should destroy required_course" do
    assert_difference('RequiredCourse.count', -1) do
      delete :destroy, id: @required_course
    end

    assert_redirected_to required_courses_path
  end
end
