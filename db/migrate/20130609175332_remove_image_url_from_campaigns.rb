class RemoveImageUrlFromCampaigns < ActiveRecord::Migration
  def change
    remove_column :campaigns, :image_url
    add_column :campaigns, :image, :string
  end
end
