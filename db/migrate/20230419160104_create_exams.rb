class CreateExams < ActiveRecord::Migration[7.0]
  def change
    create_table :exams do |t|
      t.belongs_to :exam_window
      t.string :name
      t.timestamps
    end
  end
end
