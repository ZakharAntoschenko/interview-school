class CreateSectionStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :section_students do |t|
      t.references :section, foreign_key: true, null: false
      t.references :student, foreign_key: true, null: false
      t.timestamps
    end

    add_index :section_students, [:section_id, :student_id], unique: true
  end
end
