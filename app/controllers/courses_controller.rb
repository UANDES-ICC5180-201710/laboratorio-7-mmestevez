class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :students]

  def index
    @courses = Course.all

    if params[:title]
      @courses = @courses.where("lower(title) like ?", "%#{params[:title]}%")
    end
  end


  def show
  end


  def new
    @course = Course.new
  end


  def edit
  end


  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def students
    @person = Person.new
    @enrollment = Enrollment.new
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      teacher_id = params.require(:course)[:teacher]
      if teacher_id
        teacher = Person.find(teacher_id)
      else
        teacher = nil
      end

      params.require(:course).permit(:title, :code, :quota).merge(:teacher => teacher)
    end
end
