class CreateLabSections < ActiveRecord::Migration
  def change
    create_table :lab_sections do |t|
      t.belongs_to  :lecture_section, index = true
      t.integer    :seats_remaining
      t.integer    :currently_registered
      t.integer    :term
      t.string    :section_id
      t.timestamps
    end
  end
end
