class AddRecordingToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :recording, :string
  end
end
