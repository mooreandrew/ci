class CreateJobs < ActiveRecord::Migration
  def up
    create_table :jobs do |t|
      t.string :title
      t.integer :sequence_id
      t.integer :order
      t.timestamps
    end
  end

  def down
    drop_table :jobs
  end

end
