class TutorialSectionsController < ApplicationController
  before_action :set_tutorial_section, only: [:show, :edit, :update, :destroy]

  # GET /tutorial_sections
  # GET /tutorial_sections.json
  def index
    @tutorial_sections = TutorialSection.all
  end

  # GET /tutorial_sections/1
  # GET /tutorial_sections/1.json
  def show
  end

  # GET /tutorial_sections/new
  def new
    @tutorial_section = TutorialSection.new
  end

  # GET /tutorial_sections/1/edit
  def edit
  end

  # POST /tutorial_sections
  # POST /tutorial_sections.json
  def create
    @tutorial_section = TutorialSection.new(tutorial_section_params)

    respond_to do |format|
      if @tutorial_section.save
        format.html { redirect_to @tutorial_section, notice: 'Tutorial section was successfully created.' }
        format.json { render :show, status: :created, location: @tutorial_section }
      else
        format.html { render :new }
        format.json { render json: @tutorial_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tutorial_sections/1
  # PATCH/PUT /tutorial_sections/1.json
  def update
    respond_to do |format|
      if @tutorial_section.update(tutorial_section_params)
        format.html { redirect_to @tutorial_section, notice: 'Tutorial section was successfully updated.' }
        format.json { render :show, status: :ok, location: @tutorial_section }
      else
        format.html { render :edit }
        format.json { render json: @tutorial_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutorial_sections/1
  # DELETE /tutorial_sections/1.json
  def destroy
    @tutorial_section.destroy
    respond_to do |format|
      format.html { redirect_to tutorial_sections_url, notice: 'Tutorial section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutorial_section
      @tutorial_section = TutorialSection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutorial_section_params
      params[:tutorial_section]
    end
end
