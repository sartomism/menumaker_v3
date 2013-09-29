class AddUltimousoToReceta < ActiveRecord::Migration
  def self.up
    add_column :recetas, :ultimouso, :datetime
  end

  def self.down
    remove_column :recetas, :ultimouso
  end
end
