class Student < ApplicationRecord
  attr_readonly :id

  validates :first_name, :last_name, :surname, :class_id, :school_id, presence: true
  validates :class_id, :school_id, numericality: { greater_than_or_equal_to: 0 }
end
