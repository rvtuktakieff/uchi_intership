class Student < ApplicationRecord
  attr_readonly :id

  validates :first_name, :last_name, :surname, :class_id, :school_id, presence: true
  validates :class_id, :school_id, numericality: { greater_than_or_equal_to: 0 }

  # я не смог настроить работу триггеров постгрес в тестах поэтому реализовал метод обновления
  # кол-ва студентов в модели школьного класса здесь, но тесты писал в модели класса
  after_create -> { update_count('+') }
  after_destroy -> { update_count('-') }

  private

  def update_count(operation)
    return false unless SchoolClass.find_by(id: class_id)

    db = ActiveRecord::Base.connection
    querry = "UPDATE school_classes SET students_count = students_count #{operation} 1 WHERE id = #{class_id};"
    db.execute(querry)
  end
end
