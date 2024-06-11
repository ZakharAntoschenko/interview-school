class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.references :subject, foreign_key: true, null: false, index: true
      t.references :teacher, foreign_key: true, null: false, index: true
      t.references :classroom, foreign_key: true, null: false, index: true
      t.integer :schedule_kind, null: false
      t.integer :time_duration_kind, null: false
      t.string :start_time, null: false
      t.timestamps
    end
  end
end
