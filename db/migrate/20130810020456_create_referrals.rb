class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
    	t.integer "clicker_id"
    	t.integer "sharelink_id"
    	t.boolean "call_conversion"
      t.timestamps
    end
  end
end
