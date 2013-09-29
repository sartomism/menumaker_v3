class AddPersonasToBloquecomida < ActiveRecord::Migration
  def self.up
    add_column :bloquecomidas, :personas, :integer
  end

  def self.down
    remove_column :bloquecomidas, :personas
  end
end
