class CreatePlatobloqueetiquetas < ActiveRecord::Migration
  def self.up
    create_table :platobloqueetiquetas do |t|
      t.integer :platobloque
      t.integer :etiqueta

      t.timestamps
    end
  end

  def self.down
    drop_table :platobloqueetiquetas
  end
end
