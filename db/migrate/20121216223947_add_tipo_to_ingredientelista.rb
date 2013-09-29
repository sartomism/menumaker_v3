class AddTipoToIngredientelista < ActiveRecord::Migration
  def self.up
    add_column :ingredientelistas, :tipo, :string
  end

  def self.down
    remove_column :ingredientelistas, :tipo
  end
end
