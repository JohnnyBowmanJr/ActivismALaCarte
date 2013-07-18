class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :key
      t.string :full_path
      t.integer :click_total
      t.integer :user_id

      t.timestamps
    end
  end
end
