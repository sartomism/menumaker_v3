class AddBloqueToRecetamenu < ActiveRecord::Migration
  def self.up
    add_column :recetamenus, :bloque, :integer
    add_column :recetamenus, :orden, :integer
    add_column :recetamenus, :nombrebloque, :string
  end

  def self.down
    remove_column :recetamenus, :nombrebloque
    remove_column :recetamenus, :orden
    remove_column :recetamenus, :bloque
  end
end
