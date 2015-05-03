class CreateRequiredCourses < ActiveRecord::Migration
  def change
    create_table :required_courses do |t|
      t.string  :title
      t.integer :personal_rating
      t.integer :importance
      t.integer :desired_grade
      t.integer :estimated_easiness
      t.timestamps
    end
  end
end
