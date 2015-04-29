class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.text   :description
      t.timestamps
    end
  end
end
