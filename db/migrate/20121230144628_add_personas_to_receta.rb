class AddPersonasToReceta < ActiveRecord::Migration
  def self.up
    add_column :recetas, :personas, :integer
  end

  def self.down
    remove_column :recetas, :personas
  end
end
