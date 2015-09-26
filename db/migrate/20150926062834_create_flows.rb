class CreateFlows < ActiveRecord::Migration
  def up
    create_table :flows do |t|
      t.string :title
      t.integer :orderkey
      t.timestamps
    end
  end

  def down
    drop_table :flows
  end
end
