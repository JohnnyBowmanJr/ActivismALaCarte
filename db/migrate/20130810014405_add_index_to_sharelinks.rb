class AddIndexToSharelinks < ActiveRecord::Migration
  def up
  	add_index :sharelinks, :short_key, name: 'sharelinks_short_key_index', unique: true 
  end

  def down
  	remove_index :sharelinks, :short_key
  end
end
