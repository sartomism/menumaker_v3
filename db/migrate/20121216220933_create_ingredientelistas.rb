class CreateIngredientelistas < ActiveRecord::Migration
  def self.up
    create_table :ingredientelistas do |t|
      t.string :ingrediente
      t.string :unidad
      t.float :cantidad
      t.integer :menu

      t.timestamps
    end
  end

  def self.down
    drop_table :ingredientelistas
  end
end
