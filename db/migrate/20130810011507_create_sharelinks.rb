class CreateSharelinks < ActiveRecord::Migration
  def change
    create_table :sharelinks do |t|
  	  t.string   "short_key", :null => false
	    t.boolean  "call_conversion"
	    t.integer  "referrer_id", :null => false
	    t.integer  "campaign_id", :null => false
      t.timestamps
    end
  end
end
