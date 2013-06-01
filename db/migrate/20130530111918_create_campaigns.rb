class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.string :target_name
      t.string :phone_number
      t.string :action
      t.string :start_date
      t.string :end_date
      t.string :image_url
      t.text :description
      t.integer :organizer_id

      t.timestamps
    end
  end
end
