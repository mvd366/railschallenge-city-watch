class UpdateTables < ActiveRecord::Migration
  def change
    change_column :responders, :on_duty, :boolean, :default => false
    change_column :responders, :name, :string, :unique => true
  end
end
