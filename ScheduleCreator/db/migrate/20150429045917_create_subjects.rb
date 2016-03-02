class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.text   :description
      t.string :department
      t.string :year
      t.string :session
      t.timestamps
    end
  end
end
