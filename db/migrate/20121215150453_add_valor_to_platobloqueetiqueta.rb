class AddValorToPlatobloqueetiqueta < ActiveRecord::Migration
  def self.up
    add_column :platobloqueetiquetas, :valor, :integer
  end

  def self.down
    remove_column :platobloqueetiquetas, :valor
  end
end
