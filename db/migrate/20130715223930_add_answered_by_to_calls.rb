class AddAnsweredByToCalls < ActiveRecord::Migration
  def change
  	add_column :calls, :answered_by, :string
  end
end
