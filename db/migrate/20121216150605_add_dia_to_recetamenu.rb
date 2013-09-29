class AddDiaToRecetamenu < ActiveRecord::Migration
  def self.up
    add_column :recetamenus, :dia, :integer
  end

  def self.down
    remove_column :recetamenus, :dia
  end
end
