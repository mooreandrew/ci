class CreateSequences < ActiveRecord::Migration
  def up
    create_table :sequences do |t|
      t.string :title
      t.integer :orderkey
      t.integer :stage_id
      t.timestamps
    end
  end

  def down
    drop_table :sequences
  end
end
