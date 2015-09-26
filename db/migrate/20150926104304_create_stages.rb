class CreateStages < ActiveRecord::Migration
  def up
    create_table :stages do |t|
      t.string :title
      t.integer :orderkey
      t.integer :flow_id
      t.timestamps
    end
  end

  def down
    drop_table :stages
  end
end
