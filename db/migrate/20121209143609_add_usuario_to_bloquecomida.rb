class AddUsuarioToBloquecomida < ActiveRecord::Migration
  def self.up
    add_column :bloquecomidas, :usuario, :integer
  end

  def self.down
    remove_column :bloquecomidas, :usuario
  end
end
