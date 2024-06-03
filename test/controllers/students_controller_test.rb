require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = create(:student)
  end

  test 'post /students with valid attributes' do
    student_params = @student.attributes.except('id')

    post '/students', params: student_params

    data = JSON.parse(response.body)

    assert_response :ok
    assert_equal student_params, data.except('id')
    assert_equal response.headers['x-auth-token'], AuthenticationTokenService.generate(data['id'])
  end

  test 'post /students with invalid attributes' do
    post '/students', params: {}
    assert_response :method_not_allowed
  end

  test 'delete /students/:id without token' do
    delete "/students/#{@student.id + 1}"

    assert_response :bad_request
  end

  test 'delete /students/:id with invalid token' do
    delete "/students/#{@student.id}", headers: { 'Authorization': "Bearer #{AuthenticationTokenService.generate(@student.id + 1)}" }

    assert_response :unauthorized
  end

  test 'get /schools/:school_id/classes/:class_id/students' do
    get "/schools/#{@student.school_id}/classes/#{@student.class_id}/students"

    students = Student.where(class_id: @student.class_id, school_id: @student.school_id).map(&:attributes)

    data = JSON.parse(response.body)

    assert_response :ok
    assert_equal data, { data: students }.stringify_keys
  end
end
