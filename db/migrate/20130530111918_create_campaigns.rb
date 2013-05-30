class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.string :image_url
      t.text :description
      t.integer :organizer_id

      t.timestamps
    end
  end
end
