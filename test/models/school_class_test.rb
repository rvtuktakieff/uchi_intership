require 'test_helper'

class SchoolClassTest < ActiveSupport::TestCase
  def setup
    @school_class = create(:school_class)
  end

  test 'should not create empty school class' do
    assert_difference 'SchoolClass.count', 0 do
      SchoolClass.create
    end
  end

  # запрет на изменение

  attributes_changed = [:id, :students_count]

  attributes_changed.each do |attr|
    test "should not change #{attr}" do
      assert_raises ActiveRecord::ReadonlyAttributeError do
        @school_class.send("#{attr}=", 1)
      end
    end
  end

  # наличие атрибутов

  attributes_presence = [:letter, :number]

  attributes_presence.each do |attr|
    test "school class should have value in #{attr}" do
      @school_class.send("#{attr}=", nil)

      assert_equal false, @school_class.valid?

      assert_raises ActiveRecord::RecordInvalid do
        @school_class.save!
      end
    end
  end

  # проверки number больше 0

  attributes_constraint = [:number]

  attributes_constraint.each do |attr|
    test "school class should have value in #{attr} >= 0" do
      @school_class.send("#{attr}=", -1)

      assert_equal false, @school_class.valid?

      assert_raises ActiveRecord::RecordInvalid do
        @school_class.save!
      end
    end
  end

  # проверка задания дефолтного значения students_count = 0
  test 'students_count should be 0 when create SchoolClass' do
    school_class = SchoolClass.create(letter: 'A', number: 1)

    assert_equal school_class.students_count, 0
  end

  # изменение данных students_count при создании студентов
  test 'should increase students_count when create student with for this class' do
    assert_difference '@school_class.students_count', 1 do
      create(:student, class_id: @school_class.id)

      @school_class.reload
    end
  end

  test 'shoudl decrease students_count when delete student with id this class' do
    student = create(:student, class_id: @school_class.id)
    @school_class.reload

    assert_difference '@school_class.students_count', -1 do
      student.destroy
      @school_class.reload
    end
  end
end
