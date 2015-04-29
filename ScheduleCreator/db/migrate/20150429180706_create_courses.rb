class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.belongs_to  :subject, index: true
      t.string      :courseId
      t.number      :credits
      t.boolean     :lecture_required?
      t.boolean     :lab_required?
      t.boolean     :tutorial_required?
      t.timestamps
    end
  end
end
