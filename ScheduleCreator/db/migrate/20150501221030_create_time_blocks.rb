class CreateTimeBlocks < ActiveRecord::Migration
  def change
    create_table :time_blocks do |t|
      t.string      :term
      t.string      :day
      t.number      :start_time
      t.number      :end_time
      t.belongs_to  :section, :polymorphic => true
      t.timestamps
    end
  end
end
