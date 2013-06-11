class AddImagesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image_url, :string
    add_column :users, :image_url_small, :string
  end
end
