class CreateRecetamenus < ActiveRecord::Migration
  def self.up
    create_table :recetamenus do |t|
      t.integer :platobloque
      t.integer :receta

      t.timestamps
    end
  end

  def self.down
    drop_table :recetamenus
  end
end
