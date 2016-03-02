class LectureSectionsController < ApplicationController
  before_action :set_lecture_section, only: [:show, :edit, :update, :destroy]

  # GET /lecture_sections
  # GET /lecture_sections.json
  def index
    @lecture_sections = LectureSection.all
  end

  # GET /lecture_sections/1
  # GET /lecture_sections/1.json
  def show
  end

  # GET /lecture_sections/new
  def new
    @lecture_section = LectureSection.new
  end

  # GET /lecture_sections/1/edit
  def edit
  end

  # POST /lecture_sections
  # POST /lecture_sections.json
  def create
    @lecture_section = LectureSection.new(lecture_section_params)

    respond_to do |format|
      if @lecture_section.save
        format.html { redirect_to @lecture_section, notice: 'Lecture section was successfully created.' }
        format.json { render :show, status: :created, location: @lecture_section }
      else
        format.html { render :new }
        format.json { render json: @lecture_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lecture_sections/1
  # PATCH/PUT /lecture_sections/1.json
  def update
    respond_to do |format|
      if @lecture_section.update(lecture_section_params)
        format.html { redirect_to @lecture_section, notice: 'Lecture section was successfully updated.' }
        format.json { render :show, status: :ok, location: @lecture_section }
      else
        format.html { render :edit }
        format.json { render json: @lecture_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lecture_sections/1
  # DELETE /lecture_sections/1.json
  def destroy
    @lecture_section.destroy
    respond_to do |format|
      format.html { redirect_to lecture_sections_url, notice: 'Lecture section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture_section
      @lecture_section = LectureSection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_section_params
      params[:lecture_section]
    end
end
