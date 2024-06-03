class StudentsController < ApplicationController
  include AuthenticateConcern

  before_action :authenticate_user, only: :destroy

  def create
    student = Student.new(student_params)

    if student.save
      set_header_x_auth_token(student.id)
      render(json: student, status: :ok)
    else
      head(:method_not_allowed)
    end
  end

  def destroy
    student = Student.find_by(id: params[:id])

    return head(:bad_request) unless student

    head(:unauthorized) unless @student&.id == student.id
  end

  def class_students
    students = Student.where(class_id: params[:class_id], school_id: params[:school_id])
    render(json: { data: students }, status: :ok)
  end

  private

  def student_params
    params.permit(:first_name, :last_name, :surname, :class_id, :school_id)
  end
end
