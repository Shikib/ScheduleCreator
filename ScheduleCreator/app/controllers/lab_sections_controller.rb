class LabSectionsController < ApplicationController
  before_action :set_lab_section, only: [:show, :edit, :update, :destroy]

  # GET /lab_sections
  # GET /lab_sections.json
  def index
    @lab_sections = LabSection.all
  end

  # GET /lab_sections/1
  # GET /lab_sections/1.json
  def show
  end

  # GET /lab_sections/new
  def new
    @lab_section = LabSection.new
  end

  # GET /lab_sections/1/edit
  def edit
  end

  # POST /lab_sections
  # POST /lab_sections.json
  def create
    @lab_section = LabSection.new(lab_section_params)

    respond_to do |format|
      if @lab_section.save
        format.html { redirect_to @lab_section, notice: 'Lab section was successfully created.' }
        format.json { render :show, status: :created, location: @lab_section }
      else
        format.html { render :new }
        format.json { render json: @lab_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lab_sections/1
  # PATCH/PUT /lab_sections/1.json
  def update
    respond_to do |format|
      if @lab_section.update(lab_section_params)
        format.html { redirect_to @lab_section, notice: 'Lab section was successfully updated.' }
        format.json { render :show, status: :ok, location: @lab_section }
      else
        format.html { render :edit }
        format.json { render json: @lab_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lab_sections/1
  # DELETE /lab_sections/1.json
  def destroy
    @lab_section.destroy
    respond_to do |format|
      format.html { redirect_to lab_sections_url, notice: 'Lab section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lab_section
      @lab_section = LabSection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lab_section_params
      params[:lab_section]
    end
end
