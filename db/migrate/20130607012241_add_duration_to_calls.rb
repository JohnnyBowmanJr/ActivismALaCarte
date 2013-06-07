class AddDurationToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :duration, :integer
  end
end
