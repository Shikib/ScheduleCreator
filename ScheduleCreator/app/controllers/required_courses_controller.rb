class RequiredCoursesController < ApplicationController
  before_action :set_required_course, only: [:show, :edit, :update, :destroy]

  # GET /required_courses
  # GET /required_courses.json
  def index
    @required_courses = RequiredCourse.all
  end

  # GET /required_courses/1
  # GET /required_courses/1.json
  def show
  end

  # GET /required_courses/new
  def new
    @required_course = RequiredCourse.new
  end

  # GET /required_courses/1/edit
  def edit
  end

  # POST /required_courses
  # POST /required_courses.json
  def create
    @params = create_rc_params

    @required_course = RequiredCourse.new(@params)

    respond_to do |format|
      if @required_course.save
        format.html { redirect_to @required_course, notice: 'Required course was successfully created.' }
        format.json { render :show, status: :created, location: @required_course }
      else
        format.html { render :new }
        format.json { render json: @required_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /required_courses/1
  # PATCH/PUT /required_courses/1.json
  def update
    respond_to do |format|
      if @required_course.update(required_course_params)
        format.html { redirect_to @required_course, notice: 'Required course was successfully updated.' }
        format.json { render :show, status: :ok, location: @required_course }
      else
        format.html { render :edit }
        format.json { render json: @required_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /required_courses/1
  # DELETE /required_courses/1.json
  def destroy
    @required_course.destroy
    respond_to do |format|
      format.html { redirect_to required_courses_url, notice: 'Required course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_required_course
      @required_course = RequiredCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def required_course_params
      params[:required_course]
    end

    # Get params for creation
    def create_rc_params
      params.require(:department)
      params.require(:courseId)
      params.require(:personal_rating)
      params.require(:importance)
      params.require(:desired_grade)
      params.require(:estimated_difficulty)
      params.permit(:department, :courseId, :personal_rating,
                    :importance, :desired_grade, :estimated_difficulty)
    end
end
