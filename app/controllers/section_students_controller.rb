class SectionStudentsController < ApplicationController
  before_action :_set_section_student, only: [:edit, :destroy]
  before_action :_set_student, only: %i[new create index]

  def index
    @section_students = SectionStudent.where(student_id: params[:student_id])
  end

  def new
    @section_student = SectionStudent.new
  end

  def create
    @section_student = SectionStudent.new(_section_student_params.merge({ student_id: params[:student_id] }))

    respond_to do |format|
      if @section_student.save
        format.html { redirect_to student_section_students_url(@section_student.student_id), notice: 'Section student was successfully created.' }
        format.json { render :show, status: :created, location: @section_student }
      else
        format.html { render :new }
        format.json { render json: @section_student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @section_student.destroy
    respond_to do |format|
      format.html { redirect_to student_section_students_url(@section_student.student_id), notice: 'Section student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def _set_student
    @student = Student.find(params[:student_id])
  end

  def _set_section_student
    @section_student = SectionStudent.find(params[:id])
  end

  def _section_student_params
    params.require(:section_student).permit(:section_id)
  end
end
