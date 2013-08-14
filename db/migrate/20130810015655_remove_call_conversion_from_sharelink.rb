class RemoveCallConversionFromSharelink < ActiveRecord::Migration
  def change
  	remove_column :sharelinks, :call_conversion
  end
end
