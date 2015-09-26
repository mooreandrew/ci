class CreateSequences < ActiveRecord::Migration
  def up
    create_table :sequences do |t|
      t.string :title
      t.integer :order
      t.integer :stage
      t.integer :flow_id
      t.timestamps
    end
  end

  def down
    drop_table :sequences
  end
end
