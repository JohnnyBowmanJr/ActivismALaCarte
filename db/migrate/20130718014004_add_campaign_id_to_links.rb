class AddCampaignIdToLinks < ActiveRecord::Migration
  def change
  	add_column :links, :campaign_id, :integer
  	add_index :links, :key, unique: true
  end
end
