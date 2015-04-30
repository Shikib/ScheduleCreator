class CreateTutorialSections < ActiveRecord::Migration
  def change
    create_table :tutorial_sections do |t|
      t.belongs_to  :lecture_section, index = true
      t.string    :section_id
      t.string    :title
      t.integer    :seats_remaining
      t.integer    :currently_registered
      t.integer    :term
      t.timestamps
    end
  end
end
