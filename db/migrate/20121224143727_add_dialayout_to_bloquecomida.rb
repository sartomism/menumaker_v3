class AddDialayoutToBloquecomida < ActiveRecord::Migration
  def self.up
    add_column :bloquecomidas, :dia, :integer
    add_column :bloquecomidas, :menulayout, :integer
  end

  def self.down
    remove_column :bloquecomidas, :menulayout
    remove_column :bloquecomidas, :dia
  end
end
