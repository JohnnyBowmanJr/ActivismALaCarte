class AddTwilioIdToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :twilio_id, :string
  end
end
