class AddMenuToRecetamenu < ActiveRecord::Migration
  def self.up
    add_column :recetamenus, :menu, :integer
  end

  def self.down
    remove_column :recetamenus, :menu
  end
end
