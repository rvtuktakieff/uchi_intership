class SchoolClass < ApplicationRecord
  attr_readonly :id, :students_count

  validates :number, :letter, :students_count, presence: true
  validates :number, :students_count, numericality: { greater_than_or_equal_to: 0 }
end
