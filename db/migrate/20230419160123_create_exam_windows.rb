class CreateExamWindows < ActiveRecord::Migration[7.0]
  def change
    create_table :exam_windows do |t|
      t.datetime :start_time
      t.timestamps
    end
  end
end
