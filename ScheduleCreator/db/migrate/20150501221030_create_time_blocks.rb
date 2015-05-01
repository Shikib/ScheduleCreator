class CreateTimeBlocks < ActiveRecord::Migration
  def change
    create_table :time_blocks do |t|
      t.string      :term
      t.string      :day
      t.integer      :start_time
      t.integer      :end_time
      t.belongs_to  :section, :polymorphic => true
      t.timestamps
    end
  end
end
