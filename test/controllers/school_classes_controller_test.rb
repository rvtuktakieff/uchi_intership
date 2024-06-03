require 'test_helper'

class SchoolClassesControllerTest < ActionDispatch::IntegrationTest
  test 'get /schools/:school_id/classes' do
    create_list(:school_class, 10)

    get '/schools/:school_id/classes'

    school_classes = SchoolClass.all.map(&:attributes)

    response_data = JSON.parse(response.body)

    assert_response :ok
    assert_equal response_data, { data: school_classes }.stringify_keys
  end
end
