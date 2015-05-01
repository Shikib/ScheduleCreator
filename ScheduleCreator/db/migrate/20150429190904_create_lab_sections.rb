class CreateLabSections < ActiveRecord::Migration
  def change
    create_table :lab_sections do |t|
      t.belongs_to  :lecture_section, index = true
      t.string    :section_id
      t.string    :title
      t.integer    :seats_remaining
      t.integer    :currently_registered
      t.timestamps
    end
  end
end
