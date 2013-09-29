class AddPersonasToRecetamenu < ActiveRecord::Migration
  def self.up
    add_column :recetamenus, :personas, :integer
  end

  def self.down
    remove_column :recetamenus, :personas
  end
end
