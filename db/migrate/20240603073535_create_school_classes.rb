class CreateSchoolClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :school_classes do |t|
      t.integer :number, null: false
      t.string :letter, null: false
      t.integer :students_count, null: false, default: 0
      # в схеме не было таймстемпов
      # t.timestamps
    end
    add_check_constraint :school_classes, "number >= 0", name: "number_check"
    add_check_constraint :school_classes, "students_count >= 0", name: "students_count_check"
  end
end
