class CreateRequiredCourses < ActiveRecord::Migration
  def change
    create_table :required_courses do |t|
      t.string  :department
      t.string  :courseId
      t.integer :personal_rating
      t.integer :importance
      t.integer :desired_grade
      t.integer :estimated_difficulty
      t.timestamps
    end
  end
end
