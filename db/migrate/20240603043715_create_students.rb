class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :surname, null: false
      t.integer :class_id, null: false
      t.integer :school_id, null: false
      # в схеме не было таймстемпов
      # t.timestamps
    end

    add_check_constraint :students, "class_id >= 0", name: "class_id_check"
    add_check_constraint :students, "school_id >= 0", name: "school_id_check"
  end
end
