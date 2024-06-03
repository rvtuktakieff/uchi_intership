require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  def setup
    @student = create(:student)
  end

  test 'should not create empty student' do
    assert_difference 'Student.count', 0 do
      Student.create
    end
  end

  test 'should not change id' do
    assert_raises ActiveRecord::ReadonlyAttributeError do
      @student.id = 1
    end
  end

  # проверки наличия атрибутов

  attributes_presence = [:first_name, :last_name, :surname, :class_id, :school_id]

  attributes_presence.each do |attr|
    test "student should have value in #{attr}" do
      @student.send("#{attr}=", nil)

      assert_equal false, @student.valid?

      assert_raises ActiveRecord::RecordInvalid do
        @student.save!
      end
    end
  end

  # проверки school_id, class_id больше 0

  attributes_constraint = [:class_id, :school_id]

  attributes_constraint.each do |attr|
    test "student should have value in #{attr} >= 0" do
      @student.send("#{attr}=", -1)

      assert_equal false, @student.valid?

      assert_raises ActiveRecord::RecordInvalid do
        @student.save!
      end
    end
  end
end
